import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
            // BuildIconAndGradients(
            //   colors: const [
            //     [Colors.red, Colors.blue]
            //   ],
            //   svgs: const ['fi-br-a.svg'],
            //   onColorChange: (val) {},
            //   onSvgChange: (val) {},
            // ),
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
