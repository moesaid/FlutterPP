import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Clients/client_index_controller.dart';
import 'package:flutterpp/App/Views/Pages/Client/Widgets/build_client_create_or_edit_dialog.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class BuildClientIndexHeader extends StatelessWidget {
  const BuildClientIndexHeader({
    super.key,
    required this.controller,
    required this.formKey,
  });

  final ClientIndexController controller;
  final GlobalKey<FormBuilderState> formKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.sp),
      child: Row(
        children: [
          Text(
            'All Clients',
            style: TextStyle(fontSize: 14.sp),
          ),
          SizedBox(width: 2.sp),
          Text(
            '(${controller.clients.length})',
            style: TextStyle(
              fontSize: 10.sp,
              color: Get.theme.colorScheme.secondary,
            ),
          ),
          const Spacer(),
          FilledButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => BuildClientCreateOrEditDialog(
                  formKey: formKey,
                ),
              );
            },
            child: const Text('Create Client'),
          ),
        ],
      ),
    );
  }
}
