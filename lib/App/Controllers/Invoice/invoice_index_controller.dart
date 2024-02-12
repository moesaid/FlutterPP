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

  final _filter = 'draft'.obs;
  String get filter => _filter.value;

  final _length = 10.obs;
  int get length => _length.value;

  @override
  Future<void> onInit() async {
    await _fetchApi();
    super.onInit();
  }

  // fetch api
  Future<void> _fetchApi() async {
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
  void onLengthChange(int value) {
    _length.value = value;

    Get.showOverlay(
      asyncFunction: () => _getInvoices(limit: value),
      loadingWidget: const BuildOverlay(),
    );

    update();
  }

  // view single invoice
  void viewInvoice(String id) {
    Get.toNamed(AppRoutes.INVOICE_SINGLE, arguments: id);
  }

  // delete single invoice
  void deleteInvoice(String id) {
    print(id);
  }

  // edit single invoice
  void editInvoice(String id) {
    print(id);
  }

  // duplicate single invoice
  void duplicateInvoice(String id) {
    print(id);
  }

  // export as pdf
  void exportAsPdf(String id) {
    print(id);
  }

  // print invoice
  void printInvoice(String id) {
    print(id);
  }

  // get clients
  _getClients() async {
    List<ClientModel>? res = await _clientServices.getClientsByTeamId();

    if (res == null) return;

    _clients.assignAll(res);
  }

  // get invoices
  _getInvoices({int? limit = 10}) async {
    List<InvoiceModel>? res = await _invoiceServices.getInvoicesByTeamId(
      limit: limit,
    );

    if (res == null) return;

    // get outstanding items
    List<InvoiceModel>? outstandingItems = res.where((el) {
      if (el.dueDate == null) return false;
      DateTime dueDate = DateTime.parse(el.dueDate!);
      return dueDate.isAfter(DateTime.now());
    }).toList();

    double totalOutstanding = 0;
    for (var item in outstandingItems) {
      totalOutstanding += InvoiceHelper.calculateInvoiceTotal(item);
    }

    // get overdue items
    List<InvoiceModel>? overdueItems = res.where((el) {
      if (el.dueDate == null) return false;
      DateTime dueDate = DateTime.parse(el.dueDate!);
      return dueDate.isBefore(DateTime.now());
    }).toList();

    double totalOverdue = 0;
    for (var item in overdueItems) {
      totalOverdue += InvoiceHelper.calculateInvoiceTotal(item);
    }

    _invoices.assignAll(res);
    _filteredInvoices.assignAll(res);
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
