import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Services/Client/client_services.dart';
import 'package:flutterpp/App/Services/Invoice/invoice_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/App/Views/Global/build_snackbar.dart';
import 'package:flutterpp/Helpers/invoice_helper.dart';
import 'package:flutterpp/Routes/app_pages.dart';
import 'package:get/get.dart';

class InvoiceIndexController extends GetxController {
  final ClientServices _clientServices = ClientServices();
  final InvoiceServices _invoiceServices = InvoiceServices();

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _clients = <ClientModel>[].obs;
  List<ClientModel> get clients => _clients;

  final _invoices = <InvoiceModel>[].obs;
  List<InvoiceModel> get invoices => _invoices;

  final _filteredInvoices = <InvoiceModel>[].obs;
  List<InvoiceModel> get filteredInvoices => _filteredInvoices;

  final _outstanding = 0.0.obs;
  double get outstanding => _outstanding.value;

  final _overdue = 0.0.obs;
  double get overdue => _overdue.value;

  final _filter = 'all'.obs;
  String get filter => _filter.value;

  final _length = 1000.obs;
  int get length => _length.value;

  @override
  Future<void> onInit() async {
    await fetchApi();
    super.onInit();
  }

  // fetch api
  Future<void> fetchApi() async {
    await _getClients();
    await _getInvoices();
    updateLoading(false);
  }

  // update loading
  void updateLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  // on filter change
  Future<void> onFilterChange(String value) async {
    _filter.value = value;

    if (value == 'all') {
      _filteredInvoices.assignAll(_invoices);
    } else {
      _filteredInvoices.assignAll(
        _invoices.where((el) => el.status == value).toList(),
      );
    }

    update();
  }

  // on length change
  Future<void> onLengthChange(int value) async {
    _length.value = value;

    // limit invoices list
    _filteredInvoices.assignAll(_invoices.take(value).toList());

    update();
  }

  // view single invoice
  void viewInvoice(InvoiceModel item) {
    Get.toNamed(AppRoutes.INVOICE_SINGLE, arguments: item);
  }

  // delete single invoice
  Future<void> deleteInvoice(InvoiceModel item) async {
    await Get.showOverlay(
      asyncFunction: () async {
        await _invoiceServices.deleteInvoice(invoiceId: item.id!);
        await _getInvoices();
      },
      loadingWidget: const BuildOverlay(),
    );
    update();
  }

  // duplicate single invoice
  Future<void> duplicateInvoice(InvoiceModel item) async {
    item.id = null;
    item.status = 'draft';
    item.createdAt = null;
    item.updatedAt = null;

    await Get.showOverlay(
      asyncFunction: () async {
        InvoiceModel? res = await _invoiceServices.createInvoice(invoice: item);
        if (res == null) return;
        await _getInvoices();
      },
      loadingWidget: const BuildOverlay(),
    );

    update();
  }

  // export as pdf
  Future<void> exportAsPdf(InvoiceModel item) async {
    await _invoiceServices.downloadOrPrintInvoice(
      invoice: item,
    );
  }

  // print invoice
  Future<void> printInvoice(InvoiceModel item) async {
    await _invoiceServices.downloadOrPrintInvoice(
      invoice: item,
      isPrint: true,
    );
  }

  // get clients
  _getClients() async {
    List<ClientModel>? res = await _clientServices.getClientsByTeamId();

    if (res == null) return;

    _clients.assignAll(res);
  }

  // get invoices
  _getInvoices({int? limit = 1000}) async {
    List<InvoiceModel>? res = await _invoiceServices.getInvoicesByTeamId(
      limit: limit,
    );

    if (res == null) return;

    _invoices.assignAll(res);
    _filteredInvoices.assignAll(res);

    _calculateOutstanding();
  }

  // calculate outstanding and overdue
  void _calculateOutstanding() {
    // get outstanding items
    List<InvoiceModel>? outstandingItems = _invoices.where((el) {
      if (el.dueDate == null) return false;
      DateTime dueDate = DateTime.parse(el.dueDate!);
      return dueDate.isAfter(DateTime.now());
    }).toList();

    double totalOutstanding = 0;
    for (var item in outstandingItems) {
      totalOutstanding += InvoiceHelper.calculateInvoiceTotal(item);
    }

    // get overdue items
    List<InvoiceModel>? overdueItems = _invoices.where((el) {
      if (el.dueDate == null) return false;
      DateTime dueDate = DateTime.parse(el.dueDate!);
      return dueDate.isBefore(DateTime.now());
    }).toList();

    double totalOverdue = 0;
    for (var item in overdueItems) {
      totalOverdue += InvoiceHelper.calculateInvoiceTotal(item);
    }

    _outstanding.value = totalOutstanding;
    _overdue.value = totalOverdue;
  }

  // create invoice
  void createInvoice() {
    if (_clients.isEmpty) {
      BuildSnackBar(
        title: 'Oops!',
        message: 'Please create a client first',
      ).error();

      return;
    }

    print('create invoice');
  }
}
