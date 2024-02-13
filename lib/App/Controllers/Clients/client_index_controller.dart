import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Services/Client/client_services.dart';
import 'package:flutterpp/App/Views/Global/build_overlay.dart';
import 'package:flutterpp/App/Views/Global/build_snackbar.dart';
import 'package:get/get.dart';

class ClientIndexController extends GetxController {
  final ClientServices _clientServices = ClientServices();

  final _clients = <ClientModel>[].obs;
  List<ClientModel> get clients => _clients;

  final _activeClient = ClientModel().obs;
  ClientModel get activeClient => _activeClient.value;

  final _currentStep = 0.obs;
  int get currentStep => _currentStep.value;

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

  // update active client
  void updateActiveClient(ClientModel value) {
    _activeClient.value = value;
  }

  Future<void> onStepContinue(GlobalKey<FormBuilderState> formKey) async {
    // if first step
    if (currentStep == 0) {
      _currentStep.value = 1;
      update();
      return;
    }

    // if second step
    if (currentStep == 1) {
      if (formKey.currentState!.saveAndValidate()) {
        _activeClient.value = _activeClient.value.copyWith(
          name: formKey.currentState?.fields['name']?.value,
          email: formKey.currentState?.fields['email']?.value,
          phone: formKey.currentState?.fields['phone']?.value,
          address: formKey.currentState?.fields['address']?.value,
          logo: formKey.currentState?.fields['logo']?.value,
          currency: formKey.currentState?.fields['currency']?.value,
          currencySymbol: formKey.currentState?.fields['currencySymbol']?.value,
          website: formKey.currentState?.fields['website']?.value,
          internalNotes: formKey.currentState?.fields['internalNotes']?.value,
        );

        await Get.showOverlay(
          asyncFunction: () async {
            if (activeClient.id != null) {
              await _clientServices.updateClient(client: activeClient);
            } else {
              await _clientServices.createClient(client: activeClient);
            }

            await _getClients();
            update();

            _currentStep.value = 0;
            formKey.currentState!.reset();
            _activeClient.value = ClientModel();
            update();

            Get.back();
          },
          loadingWidget: const BuildOverlay(),
        );
      } else {
        BuildSnackBar(
          title: 'Oops!',
          message: formKey.currentState?.errors.entries.first.value ?? '',
        ).error();
      }
    }
  }

  // on step tapped
  void onStepTapped(int index) {
    _currentStep.value = index;
    update();
  }
}
