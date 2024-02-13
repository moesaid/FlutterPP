import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/src/form_builder.dart';
import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Models/team_model.dart';
import 'package:flutterpp/App/Services/Invoice/invoice_services.dart';
import 'package:flutterpp/App/Services/Team/team_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/App/Views/Global/build_snackbar.dart';
import 'package:get/get.dart';

class InvoiceCreateOrEditController extends GetxController {
  final TeamServices _teamServices = TeamServices();
  final InvoiceServices _invoiceServices = InvoiceServices();

  final _clients = <ClientModel>[].obs;
  List<ClientModel> get clients => _clients;

  final _activeClient = ClientModel().obs;
  ClientModel get activeClient => _activeClient.value;

  final _team = TeamModel().obs;
  TeamModel get team => _team.value;

  final _invoice = InvoiceModel().obs;
  InvoiceModel get invoice => _invoice.value;

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _customInvoice = InvoiceModel().obs;
  InvoiceModel get customInvoice => _customInvoice.value;

  // fetch api
  Future<void> fetchApi({
    InvoiceModel? invoice,
    List<ClientModel>? clintes,
  }) async {
    // get invoice
    if (invoice != null) {
      _invoice.value = invoice;
      _customInvoice.value = invoice;
    }

    // get clients
    if (clintes != null) {
      _clients.value = clintes;
      _activeClient.value = clintes.firstWhereOrNull(
            (el) => el.id == invoice?.clientId,
          ) ??
          ClientModel();
    }

    // get team
    await _getTeam();

    updateLoading(false);
  }

  void updateLoading(bool bool) {
    _isLoading.value = bool;
    update();
  }

  _getTeam() async {
    _team.value = (await _teamServices.getTeamForAuthUser())!;
  }

  // on client selected
  void onClientSelected(ClientModel val) {
    _activeClient.value = val;
    update();

    Get.back();
  }

  Future<void> onSubmit({
    required GlobalKey<FormBuilderState> formHeaderKey,
    required GlobalKey<FormBuilderState> formFooterKey,
    VoidCallback? callback,
  }) async {
    // validate forms
    formHeaderKey.currentState?.save();
    formFooterKey.currentState?.save();

    if (formHeaderKey.currentState?.validate() == false ||
        formFooterKey.currentState?.validate() == false) {
      return;
    }

    // update invoice
    _updateCustomInvoiceData(formHeaderKey, formFooterKey);

    // check if items and number is not empty
    if (_customInvoice.value.items == null ||
        _customInvoice.value.items!.isEmpty ||
        _customInvoice.value.number == null) {
      BuildSnackBar(
        title: 'Oops!',
        message: 'Please add at least one item!',
      ).error();
      return;
    }

    // check if client is selected
    if (_activeClient.value.id == null) {
      BuildSnackBar(
        title: 'Oops!',
        message: 'Please select a client',
      ).error();
      return;
    }

    InvoiceModel? res = await Get.showOverlay(
      asyncFunction: () async {
        if (_customInvoice.value.id != null) {
          return await _invoiceServices.updateInvoice(
            invoice: _customInvoice.value.copyWith(
              updatedAt: DateTime.now().toString(),
            ),
          );
        }
        return await _invoiceServices.createInvoice(
          invoice: _customInvoice.value,
          customCreatedAt: true,
        );
      },
      loadingWidget: const BuildOverlay(),
    );

    Get.back();

    if (res != null) {
      BuildSnackBar(
        title: 'Success!',
        message: 'Invoice created successfully!',
      ).success();

      callback?.call();
    } else {
      BuildSnackBar(
        title: 'Oops!',
        message: 'Something went wrong!',
      ).error();
    }
  }

  // update custom invoice data
  void _updateCustomInvoiceData(
    GlobalKey<FormBuilderState> formHeaderKey,
    GlobalKey<FormBuilderState> formFooterKey,
  ) {
    _customInvoice.value.clientId = _activeClient.value.id;
    _customInvoice.value.teamId = _team.value.id;
    _customInvoice.value.clientName = _activeClient.value.name;
    _customInvoice.value.status = 'draft';
    _customInvoice.value.number =
        int.parse(formHeaderKey.currentState?.value['number']);
    _customInvoice.value.createdAt =
        formHeaderKey.currentState?.value['date'].toString();
    _customInvoice.value.dueDate =
        formHeaderKey.currentState?.value['dueDate'].toString();
    _customInvoice.value.discount =
        formFooterKey.currentState?.value['discount'];
    _customInvoice.value.tax = formFooterKey.currentState?.value['tax'];
  }

  // on add item
  void onAddItem(InvoiceItem item) {
    _customInvoice.value.items ??= [];
    _customInvoice.value.items?.add(item);
    update();
  }

  // on remove item
  void onRemoveItem(InvoiceItem item) {
    if (_customInvoice.value.items == null) return;

    _customInvoice.value.items?.remove(item);
    update();
  }

  // update currency
  void updateCurrency(Currency currency) {
    _customInvoice.value.currency = currency.code;
    _customInvoice.value.currencySymbol = currency.symbol;
    update();
  }
}
