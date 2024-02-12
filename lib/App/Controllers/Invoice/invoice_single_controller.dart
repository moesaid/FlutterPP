import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Models/team_model.dart';
import 'package:flutterpp/App/Services/Client/client_services.dart';
import 'package:flutterpp/App/Services/Invoice/invoice_services.dart';
import 'package:flutterpp/App/Services/Team/team_services.dart';
import 'package:get/get.dart';

class InvoiceSingleController extends GetxController {
  final InvoiceServices _invoiceServices = InvoiceServices();
  final TeamServices _teamServices = TeamServices();
  final ClientServices _clientServices = ClientServices();

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _invoice = InvoiceModel().obs;
  InvoiceModel get invoice => _invoice.value;

  final _team = TeamModel().obs;
  TeamModel get team => _team.value;

  final _client = ClientModel().obs;
  ClientModel get client => _client.value;

  @override
  Future<void> onInit() async {
    await _fetchApi();
    updateLoading(false);
    super.onInit();
  }

  // fetch api
  Future<void> _fetchApi() async {
    await _getInvoice();
    await _getTeam();
    await _getClient();
    updateLoading(false);
  }

  // get invoice
  Future<void> _getInvoice() async {
    _invoice.value = Get.arguments as InvoiceModel;
  }

  // get team
  Future<void> _getTeam() async {
    _team.value = (await _teamServices.getTeamForAuthUser())!;
  }

  // get client
  Future<void> _getClient() async {
    if (_invoice.value.clientId == null) return;
    _client.value = (await _clientServices.getClientById(
        clientId: _invoice.value.clientId!))!;
  }

  // update loading
  void updateLoading(bool value) {
    _isLoading.value = value;
    update();
  }

  // print
  onPrint() {
    print('print');
  }

  // download
  onDownload() {
    _invoiceServices.downloadInvoice(
      invoice: invoice,
      team: team,
      client: client,
    );
  }

  // edit
  onEdit() {
    print('edit');
  }
}
