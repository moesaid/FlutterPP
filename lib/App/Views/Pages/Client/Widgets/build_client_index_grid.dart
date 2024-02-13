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
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
        childAspectRatio: 1.5,
      ),
      itemCount: controller.clients.length,
      padding: EdgeInsets.all(3.sp),
      itemBuilder: (_, int index) {
        ClientModel item = controller.clients[index];
        return InkWell(
          onTap: () {
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
          child: Card(
            elevation: 0,
            color: Get.theme.colorScheme.primaryContainer,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  dense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 3.sp,
                    vertical: 1.sp,
                  ),
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
                const Spacer(),
                Padding(
                  padding: EdgeInsets.all(6.sp),
                  child: Text(
                    '${item.address ?? ''}, \n${item.city ?? ''}, ${item.state ?? ''}, ${item.zip ?? ''}, \n${item.country ?? ''}',
                    overflow: TextOverflow.ellipsis,
                    style: Get.textTheme.bodySmall,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
