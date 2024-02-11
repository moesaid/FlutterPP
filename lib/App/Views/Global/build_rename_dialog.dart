import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Views/Global/buiuld_dialog.dart';
import 'package:get/get.dart';

class BuildRenameDialog extends StatelessWidget {
  const BuildRenameDialog({
    super.key,
    required this.callback,
    required this.title,
  });

  final void Function(String?) callback;
  final String title;

  @override
  Widget build(BuildContext context) {
    final renameKey = GlobalKey<FormBuilderState>();
    return BuildDefultDialog(
      height: 130,
      child: FormBuilder(
        key: renameKey,
        child: Column(
          children: [
            FormBuilderTextField(
              name: 'title',
              initialValue: title,
            ),
            const Spacer(),
            SizedBox(
              width: Get.context?.width,
              child: FilledButton(
                onPressed: () {
                  if (renameKey.currentState?.saveAndValidate() ?? false) {
                    callback.call(
                      renameKey.currentState!.fields['title']!.value,
                    );

                    Get.back();
                  }
                },
                child: Text('update'.capitalize!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
