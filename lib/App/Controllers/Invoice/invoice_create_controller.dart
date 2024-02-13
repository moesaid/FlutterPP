import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Models/invoice_model.dart';
import 'package:flutterpp/App/Models/team_model.dart';
import 'package:flutterpp/App/Services/Team/team_services.dart';
import 'package:get/get.dart';

class InvoiceCreateController extends GetxController {
  final TeamServices _teamServices = TeamServices();

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

  // fetch api
  Future<void> fetchApi({
    InvoiceModel? invoice,
    List<ClientModel>? clintes,
  }) async {
    // get invoice
    if (invoice != null) {
      _invoice.value = invoice;
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
}
