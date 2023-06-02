// import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/project_single_wiki_controller.dart';
import 'package:get/get.dart' hide Node;

import 'package:get/get.dart';

class ProjectSingleWikiPage extends GetView<ProjectSingleWikiController> {
  const ProjectSingleWikiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleWikiController>(
      init: ProjectSingleWikiController(),
      initState: (_) {},
      builder: (_) {
        return Scaffold(
            appBar: AppBar(title: const Text('ProjetSingleWikiPage')),
            body: const SafeArea(child: Text('ProjetSingleWikiController')));
      },
    );
  }
}


// class ProjectSingleWikiPage extends GetView<ProjectSingleWikiController> {
//   const ProjectSingleWikiPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProjectSingleWikiController>(
//       init: ProjectSingleWikiController(),
//       initState: (_) {},
//       builder: (_) {
//         return Scaffold(
//           body: controller.isLoading
//               ? const SizedBox()
//               : Column(
//                   children: [
//                     Expanded(
//                       child: KeyboardListener(
//                         focusNode: controller.focusNode,
//                         onKeyEvent: (_) {
//                           controller.updateEditorState(true);
//                         },
//                         child: AppFlowyEditor(
//                           themeData: customizeEditorTheme(context),
//                           editorState: controller.editorState,
//                           autoFocus: true,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: controller.isNeedToSave
//                 ? () => controller.createOrUpdateWiki()
//                 : null,
//             backgroundColor: controller.isNeedToSave
//                 ? Get.theme.colorScheme.secondary
//                 : Get.theme.colorScheme.primaryContainer,
//             child: controller.isSaving
//                 ? const CircularProgressIndicator()
//                 : Icon(
//                     Icons.save,
//                     color: controller.isNeedToSave
//                         ? Get.theme.iconTheme.color
//                         : Get.theme.colorScheme.secondaryContainer,
//                   ),
//           ),
//         );
//       },
//     );
//   }
// }

// ThemeData customizeEditorTheme(BuildContext context) {
//   final dark = EditorStyle.dark;
//   final editorStyle = dark.copyWith(
//     padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
//     cursorColor: Get.theme.colorScheme.secondary,
//     selectionColor: Get.theme.colorScheme.secondary.withOpacity(0.5),
//     textStyle: const TextStyle(
//       fontSize: 14,
//     ),
//     placeholderTextStyle: TextStyle(
//       color: Get.theme.colorScheme.primaryContainer,
//     ),
//     code: dark.code?.copyWith(
//       backgroundColor: Colors.lightBlue.shade200,
//       fontStyle: FontStyle.italic,
//     ),
//     highlightColorHex: '0x60ffc107',
//     backgroundColor: Get.theme.scaffoldBackgroundColor,
//   );

//   final quote = QuotedTextPluginStyle.dark.copyWith(
//     textStyle: (_, __) => TextStyle(
//       fontSize: 13,
//       color: Get.theme.colorScheme.background,
//       fontStyle: FontStyle.italic,
//       fontWeight: FontWeight.w700,
//     ),
//     icon: (editorState, textNode) => VerticalDivider(
//       color: Get.theme.colorScheme.background,
//       thickness: 3,
//     ),
//   );

//   return Theme.of(context).copyWith(extensions: [
//     editorStyle,
//     // ...darkPlguinStyleExtension,

//     quote,
//   ]);
// }
