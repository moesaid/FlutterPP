import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Views/Pages/Project/Widgets/build_icon_and_gradients.dart';
import 'package:get/get.dart';

class BuildCreateMockupInfo extends StatelessWidget {
  const BuildCreateMockupInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: FormBuilder(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Get.bottomSheet(
                  BuildIconAndGradients(
                    onColorChange: (val) {
                      print('❌ val: $val');
                    },
                    onSvgChange: (val) {
                      print('❌ val: $val');
                    },
                  ),
                  // isScrollControlled: true,
                );
              },
              icon: const Icon(Icons.cloud_download_outlined),
            ),
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: 'name',
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      hintText: 'Enter the name of the mockup',
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: FormBuilderTextField(
                    name: 'description',
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Enter the description of the mockup',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
