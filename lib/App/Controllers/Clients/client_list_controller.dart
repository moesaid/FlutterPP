import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Services/Client/client_services.dart';
import 'package:get/get.dart';

class ClientListController extends GetxController {
  final ClientServices _clientServices = ClientServices();

  final _clients = <ClientModel>[].obs;
  List<ClientModel> get clients => _clients;

  final _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  @override
  Future<void> onInit() async {
    await _fetchApi();
    updateLoading(false);
    super.onInit();
  }

  // fetch api
  Future<void> _fetchApi() async {
    await _getClients();
  }

  // get clients
  Future<void> _getClients() async {
    _clients.value = (await _clientServices.getClientsByTeamId())!;
  }

  // update loading
  void updateLoading(bool value) {
    _isLoading.value = value;
    update();
  }
}
