import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_wiki_controller.dart';
import 'package:get/get.dart' hide Node;

class ProjectSingleWikiPage extends GetView<ProjectSingleWikiController> {
  const ProjectSingleWikiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleWikiController>(
      init: ProjectSingleWikiController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
          body: Column(
            children: [
              Text(controller.isNeedToSave ? 'Need to save' : 'Saved'),
              Expanded(
                child: KeyboardListener(
                  focusNode: controller.focusNode,
                  onKeyEvent: (_) {
                    controller.updateEditorState();
                  },
                  child: AppFlowyEditor(
                    themeData: customizeEditorTheme(context),
                    editorState: controller.editorState,
                    autoFocus: true,
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: controller.isNeedToSave ? () => controller.save() : null,
            backgroundColor: controller.isNeedToSave
                ? Get.theme.colorScheme.secondary
                : Get.theme.colorScheme.primaryContainer,
            child: Icon(
              Icons.save,
              color: controller.isNeedToSave
                  ? Get.theme.iconTheme.color
                  : Get.theme.colorScheme.secondaryContainer,
            ),
          ),
        );
      },
    );
  }
}

ThemeData customizeEditorTheme(BuildContext context) {
  final dark = EditorStyle.dark;
  final editorStyle = dark.copyWith(
    padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
    cursorColor: Get.theme.colorScheme.secondary,
    selectionColor: Get.theme.colorScheme.secondary.withOpacity(0.5),
    textStyle: const TextStyle(
      fontSize: 14,
    ),
    placeholderTextStyle: TextStyle(
      color: Get.theme.colorScheme.primaryContainer,
    ),
    code: dark.code?.copyWith(
      backgroundColor: Colors.lightBlue.shade200,
      fontStyle: FontStyle.italic,
    ),
    highlightColorHex: '0x60ffc107',
    backgroundColor: Get.theme.scaffoldBackgroundColor,
  );

  final quote = QuotedTextPluginStyle.dark.copyWith(
    textStyle: (_, __) => TextStyle(
      fontSize: 13,
      color: Get.theme.backgroundColor,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w700,
    ),
    icon: (editorState, textNode) => VerticalDivider(
      color: Get.theme.backgroundColor,
      thickness: 3,
    ),
  );

  return Theme.of(context).copyWith(extensions: [
    editorStyle,
    ...darkPlguinStyleExtension,
    quote,
  ]);
}
