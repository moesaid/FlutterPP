import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Clients/client_index_controller.dart';
import 'package:flutterpp/App/Models/client_model.dart';
import 'package:flutterpp/App/Views/Pages/Client/Widgets/build_client_create_or_edit_dialog.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildClientIndexGrid extends StatelessWidget {
  const BuildClientIndexGrid({
    super.key,
    required this.controller,
    required this.formKey,
  });

  final ClientIndexController controller;
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.clients.length,
      padding: EdgeInsets.all(3.sp),
      itemBuilder: (_, int index) {
        ClientModel item = controller.clients[index];
        return Card(
          elevation: 0,
          color: Get.theme.colorScheme.primaryContainer,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 3.sp,
              vertical: 0.sp,
            ),
            child: Row(
              children: [
                Expanded(
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    minVerticalPadding: 0,
                    title: Text(
                      controller.clients[index].name ?? '',
                      style: Get.textTheme.titleSmall!,
                    ),
                    subtitle: Text(
                      controller.clients[index].email ?? '',
                      style: Get.textTheme.labelSmall,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: controller.clients[index].logo == null
                          ? Get.theme.colorScheme.secondary
                          : Get.theme.colorScheme.secondaryContainer,
                      foregroundImage: controller.clients[index].logo == null
                          ? null
                          : NetworkImage(controller.clients[index].logo!),
                      child: controller.clients[index].logo == null
                          ? Text(controller.clients[index].name?[0] ?? '')
                          : null,
                    ),
                  ),
                ),
                Text(
                  item.country ?? '',
                  style: Get.textTheme.bodyMedium,
                ),
                SizedBox(width: 5.sp),
                Badge(
                  label: Text(
                    item.currency?.toUpperCase() ?? 'usd'.toUpperCase(),
                  ),
                ),
                SizedBox(
                  height: 10.sp,
                  width: 20.sp,
                  child: const VerticalDivider(),
                ),
                FilledButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Get.theme.colorScheme.secondaryContainer,
                    ),
                  ),
                  onPressed: () {
                    controller.updateActiveClient(
                      controller.clients[index],
                    );

                    showDialog(
                      context: context,
                      builder: (_) => BuildClientCreateOrEditDialog(
                        formKey: formKey,
                      ),
                    );
                  },
                  child: const Text('Edit'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
