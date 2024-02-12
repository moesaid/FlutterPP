import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Models/team_model.dart';
import 'package:flutterpp/App/Services/Team/team_services.dart';
import 'package:get/get.dart';

class InvoiceSingleController extends GetxController {
  final TeamServices _teamServices = TeamServices();

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final _invoice = InvoiceModel().obs;
  InvoiceModel get invoice => _invoice.value;

  final _team = TeamModel().obs;
  TeamModel get team => _team.value;

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
    print('download');
  }

  // edit
  onEdit() {
    print('edit');
  }
}
