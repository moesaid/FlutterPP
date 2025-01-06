import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Clients/client_index_controller.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Pages/Client/Widgets/build_client_create_or_edit_dialog.dart';
import 'package:flutterpp/App/Views/Pages/Client/Widgets/build_client_index_grid.dart';
import 'package:flutterpp/App/Views/Pages/Client/Widgets/build_client_index_header.dart';
import 'package:get/get.dart';

class ClientIndexPage extends GetView<ClientIndexController> {
  const ClientIndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientIndexController>(
      init: ClientIndexController(),
      initState: (_) {},
      builder: (localController) {
        final formKey = GlobalKey<FormBuilderState>();
        return Scaffold(
          body: SafeArea(
            child: BuildLoadingOrEmptyLayout(
              isLoading: controller.isLoading,
              isEmpty: controller.clients.isEmpty,
              hasButton: true,
              buttonText: 'create your first client'.capitalize!,
              onButtonPressed: () {
                localController.clearFormState(formKey);
                showDialog(
                  context: context,
                  builder: (_) {
                    return BuildClientCreateOrEditDialog(
                      formKey: formKey,
                    );
                  },
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildClientIndexHeader(
                    controller: controller,
                    formKey: formKey,
                  ),
                  const Divider(thickness: 0.5),
                  Expanded(
                    child: BuildClientIndexGrid(
                      controller: controller,
                      formKey: formKey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
