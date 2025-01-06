import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutterpp/App/Controllers/Auth/setup_local_flutter_path_controller.dart';
import 'package:flutterpp/App/Views/Global/build_loading_switch.dart';
import 'package:flutterpp/App/Views/Global/build_logo.dart';
import 'package:flutterpp/App/Views/Global/buiuld_dialog.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:syntax_highlight/syntax_highlight.dart';
import 'package:tab_container/tab_container.dart';
import 'package:url_launcher/url_launcher.dart';

class SetupLocalFlutterPathPage
    extends GetView<SetupLocalFlutterPathController> {
  const SetupLocalFlutterPathPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SetupLocalFlutterPathController>(
      init: SetupLocalFlutterPathController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: SafeArea(
            child: BuildLoadingSwitch(
              isLoading: controller.isLoading,
              child: Container(
                padding:
                    EdgeInsets.only(top: 20.spa, left: 20.spa, right: 20.spa),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CloseButton(),
                    SizedBox(height: 10.spa),
                    Row(
                      children: [
                        BuildLogo(size: 20.spa),

                        const Spacer(),

                        // add path
                        FilledButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) {
                                return SetupLocalFlutterPathDialog(
                                  onSave: controller.addPath,
                                );
                              },
                            );
                          },
                          child: Text('add path'.toUpperCase()),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.spa),
                    Text(
                      'Setup FlutterPP CLI',
                      style: TextStyle(
                        fontSize: 10.spa,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5.spa),
                    Text(
                      'please provide the path to your local flutter sdk installation'
                          .capitalize!,
                      style: TextStyle(
                        fontSize: 5.spa,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Divider(height: 20.spa, thickness: 0.5),
                    Expanded(
                      child: BuildListView(controller: controller),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SetupLocalFlutterPathDialog extends StatelessWidget {
  final void Function(String)? onSave;

  const SetupLocalFlutterPathDialog({
    super.key,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    return BuildDefultDialog(
      height: 100.spa,
      child: FormBuilder(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add Path',
              style: TextStyle(
                fontSize: 10.spa,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4.spa),
            Text(
              'please provide the path to your local flutter sdk installation'
                  .capitalize!,
              style: TextStyle(
                fontSize: 5.spa,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(height: 1.spa),
            RichText(
              text: TextSpan(
                text: 'the end of the path should be'.capitalize!,
                style: TextStyle(
                  fontSize: 5.spa,
                  fontWeight: FontWeight.w300,
                ),
                children: [
                  TextSpan(
                    text: ' " flutter/bin " ',
                    style: TextStyle(
                      color: Get.theme.colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.spa),
            FormBuilderTextField(
              name: 'path',
              decoration: InputDecoration(
                labelText: 'Path',
                hintText: 'path to your local flutter sdk installation',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.spa),
                ),
              ),
              validator: FormBuilderValidators.required(),
            ),
            SizedBox(height: 10.spa),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FilledButton(
                  onPressed: () {
                    if (formKey.currentState!.saveAndValidate()) {
                      String path = formKey.currentState!.fields['path']!.value;
                      onSave?.call(path);
                      // Get.back();
                    }
                  },
                  child: Text('save path'.toUpperCase()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BuildListView extends StatelessWidget {
  const BuildListView({
    super.key,
    required this.controller,
  });

  final SetupLocalFlutterPathController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // make sure you have flutter installed
        Text(
          'make sure you have flutter installed on your machine before adding the path.'
              .capitalize!,
        ),
        Text(
          'check your flutter installation by running the following command in your terminal or command prompt:'
              .capitalize!,
        ),
        SizedBox(height: 10.spa),
        BuildCodeBlock(
          height: 130,
          theme: controller.theme,
          onCopy: controller.onCopy,
          code: controller.codes[0],
        ),
        SizedBox(height: 2.spa),

        Text(
          'if you get a sucsessful response, then you have flutter installed on your machine. continue to the next step.'
              .capitalize!,
          style: const TextStyle(
            color: Colors.greenAccent,
          ),
        ),
        Text(
          'else you need to install Flutter on your machine before you continue, you can install flutter by following the instructions on the official flutter website.'
              .capitalize!,
          style: TextStyle(
            color: Get.theme.colorScheme.error,
          ),
        ),
        SizedBox(height: 6.spa),
        Row(
          children: [
            Text('if needed: '.toUpperCase()),
            FilledButton.tonal(
              onPressed: () async {
                final Uri url = Uri.parse(
                  'https://docs.flutter.dev/get-started/install',
                );
                if (!await launchUrl(url)) {
                  Get.snackbar(
                    'Error',
                    'could not launch the url',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: Text('install flutter'.toUpperCase()),
            ),
          ],
        ),

        SizedBox(height: 10.spa),
        Text(
          'if you don\'t know the path to your local flutter sdk installation,'
                  '\nyou can find it by running the following command in your terminal or command prompt:'
              .capitalize!,
        ),
        SizedBox(height: 10.spa),
        if (!controller.isLoading)
          BuildCodeBlock(
            height: 130,
            theme: controller.theme,
            onCopy: controller.onCopy,
            code: controller.codes[1],
          ),
        SizedBox(height: 10.spa),
        Text(
          'after running the command, you will see all the paths in your terminal or command prompt.'
              .capitalize!,
        ),
        RichText(
          text: TextSpan(
            text: 'find the path that ends with'.capitalize!,
            children: [
              TextSpan(
                text: ' " flutter/bin " ',
                style: TextStyle(
                  color: Get.theme.colorScheme.error,
                ),
              ),
              const TextSpan(
                text: 'and copy it.',
              ),
            ],
          ),
        ),
        SizedBox(height: 10.spa),
        Container(
          padding: EdgeInsets.all(10.spa),
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(5.spa),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.pathsList.length,
            separatorBuilder: (_, __) => SizedBox(height: 2.spa),
            itemBuilder: (_, int index) {
              String path = controller.pathsList[index];
              bool isFlutter = path.contains('flutter');
              return Container(
                margin: !isFlutter
                    ? null
                    : EdgeInsets.symmetric(
                        vertical: 2.spa,
                      ),
                padding: !isFlutter
                    ? null
                    : EdgeInsets.symmetric(
                        horizontal: 5.spa,
                        vertical: 2.spa,
                      ),
                decoration: !isFlutter
                    ? null
                    : BoxDecoration(
                        color: Get.theme.colorScheme.primary,
                        borderRadius: BorderRadius.circular(2.spa),
                      ),
                child: Text(
                  controller.pathsList[index],
                  style: TextStyle(
                      fontSize: 4.spa,
                      fontWeight: FontWeight.w300,
                      color: isFlutter
                          ? Get.theme.colorScheme.onPrimary
                          : Get.theme.colorScheme.onPrimary
                              .withValues(alpha: 0.5)),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 10.spa),
      ],
    );
  }
}

class BuildCodeBlock extends StatelessWidget {
  final Map<String, String> code;
  final void Function(String)? onCopy;
  final HighlighterTheme theme;
  final double? height;

  const BuildCodeBlock({
    super.key,
    required this.theme,
    required this.code,
    this.onCopy,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 250,
      child: TabContainer(
        color: Get.theme.colorScheme.primaryContainer,
        tabsEnd: 0.2,
        tabs: const [
          Tab(text: 'mac'),
          Tab(text: 'windows'),
        ],
        children: [
          Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Padding(
                  padding: EdgeInsets.all(8.0.spa),
                  child: Text.rich(
                    Highlighter(
                      language: 'dart',
                      theme: theme,
                    ).highlight(code['mac'] ?? ''),
                  ),
                ),
              ),
              Positioned(
                top: 6.spa,
                right: 6.spa,
                child: IconButton(
                  onPressed: () => onCopy?.call(code['mac'] ?? ''),
                  icon: Icon(Icons.copy, size: 6.spa),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: Padding(
                  padding: EdgeInsets.all(8.0.spa),
                  child: Text.rich(
                    Highlighter(
                      language: 'dart',
                      theme: theme,
                    ).highlight(code['windows'] ?? ''),
                  ),
                ),
              ),
              Positioned(
                top: 6.spa,
                right: 6.spa,
                child: IconButton(
                  onPressed: () => onCopy?.call(code['windows'] ?? ''),
                  icon: Icon(Icons.copy, size: 6.spa),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
