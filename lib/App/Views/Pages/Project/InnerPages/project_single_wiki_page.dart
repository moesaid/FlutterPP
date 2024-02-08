import 'dart:convert';

import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_wiki_controller.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProjectSingleWikiPage extends GetView<ProjectSingleWikiController> {
  const ProjectSingleWikiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectSingleWikiController>(
      init: ProjectSingleWikiController(),
      initState: (_) {},
      builder: (_) {
        EditorState editorState = EditorState(
          document: Document.fromJson(
            {
              "document": {
                "type": "page",
                "children": [
                  {
                    "type": "heading",
                    "data": {
                      "level": 2,
                      "delta": [
                        {
                          "insert": "Welcome to",
                          "attributes": {"bold": true}
                        },
                        {"insert": " your wiki 🖐️"}
                      ],
                      "align": "left"
                    }
                  },
                  {
                    "type": "paragraph",
                    "data": {
                      "delta": [
                        {
                          "insert":
                              "Here, you can find the project overview and all the outlines you need to reference periodically."
                        }
                      ]
                    }
                  },
                  {
                    "type": "paragraph",
                    "data": {
                      "delta": [
                        {"insert": "you can always you "},
                        {
                          "insert": "\" cmd+s or ctrl+s \"",
                          "attributes": {
                            "bold": true,
                            "font_color": "0xff2196f3"
                          }
                        },
                        {"insert": " for quick save!!!"}
                      ]
                    }
                  },
                  {"type": "divider"},
                  {
                    "type": "todo_list",
                    "data": {
                      "delta": [
                        {"insert": "drink some water and take a break"},
                      ],
                      "checked": false
                    }
                  },
                  {
                    "type": "todo_list",
                    "data": {
                      "delta": [
                        {"insert": "crash some code and have fun!"},
                      ],
                      "checked": false
                    }
                  },
                  {
                    "type": "todo_list",
                    "data": {
                      "delta": [
                        {"insert": "write to us we love feedback!"},
                      ],
                      "checked": false
                    }
                  },
                  {
                    "type": "todo_list",
                    "data": {
                      "delta": [
                        {
                          "insert":
                              "we won't say no to 5 stars! on the store 😁"
                        },
                      ],
                      "checked": false
                    }
                  }
                ]
              }
            },
          ),
        );
        EditorScrollController editorScrollController =
            EditorScrollController(editorState: editorState);

        return Scaffold(
          body: Container(
            alignment: Alignment.topCenter,
            child: FloatingToolbar(
              items: [
                paragraphItem,
                ...headingItems,
                ...markdownFormatItems,
                quoteItem,
                bulletedListItem,
                numberedListItem,
                linkItem,
                buildTextColorItem(),
                buildHighlightColorItem(),
                ...textDirectionItems,
                ...alignmentItems,
              ],
              editorState: editorState,
              textDirection: TextDirection.ltr,
              editorScrollController: editorScrollController,
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  AppFlowyEditor(
                    autoFocus: true,
                    editorState: editorState,
                    editorStyle: customizeEditorStyle(),
                    blockComponentBuilders: customBuilder(),
                    commandShortcutEvents: [
                      ...standardCommandShortcutEvents,
                      CommandShortcutEvent(
                        key: 'ctrl+s',
                        command: GetPlatform.isWindows ? 'ctrl+s' : 'cmd+s',
                        handler: (EditorState editorState) {
                          print(jsonEncode(editorState.document.toJson()));
                          return KeyEventResult.handled;
                        },
                        getDescription: () {
                          return 'Save';
                        },
                      ),
                    ],
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: FilledButton(
                      onPressed: () {
                        print(editorState.document.toJson());
                      },
                      child: const Text('Save'),
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

EditorStyle customizeEditorStyle() {
  return EditorStyle(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
    cursorColor: Get.theme.colorScheme.onBackground,
    selectionColor: Colors.red.withOpacity(0.3),
    textStyleConfiguration: TextStyleConfiguration(
      text: TextStyle(
        color: Get.theme.colorScheme.onBackground,
      ),
    ),
    dragHandleColor: Colors.green,
    textSpanDecorator: (context, node, index, text, before, after) {
      return after;
    },
  );
}

Map<String, BlockComponentBuilder> customBuilder() {
  final configuration = BlockComponentConfiguration(
    padding: (node) {
      if (HeadingBlockKeys.type == node.type) {
        return const EdgeInsets.symmetric(vertical: 0, horizontal: 0);
      }
      return const EdgeInsets.symmetric(vertical: 0, horizontal: 0);
    },
    textStyle: (node) {
      if (HeadingBlockKeys.type == node.type) {
        return TextStyle(color: Get.theme.colorScheme.secondary);
      }
      return const TextStyle();
    },
  );

  // customize heading block style
  return {
    ...standardBlockComponentBuilderMap,
    // heading block
    HeadingBlockKeys.type: HeadingBlockComponentBuilder(
      configuration: BlockComponentConfiguration(
        textStyle: (node) {
          return TextStyle(
            color: Get.theme.colorScheme.onBackground,
          );
        },
      ),
    ),
    TodoListBlockKeys.type: TodoListBlockComponentBuilder(
      configuration: configuration.copyWith(
        padding: (node) => const EdgeInsets.all(0),
      ),
      textStyleBuilder: (value) {
        return TextStyle(
          color: Get.theme.colorScheme.onBackground.withOpacity(
            value ? 0.5 : 1,
          ),
          fontStyle: value ? FontStyle.italic : FontStyle.normal,
          decoration: value ? TextDecoration.lineThrough : null,
        );
      },
      iconBuilder: (context, node) {
        final checked = node.attributes[TodoListBlockKeys.checked] as bool;
        return InkWell(
          onTap: () => node.updateAttributes(
            {TodoListBlockKeys.checked: !checked},
          ),
          child: Padding(
            padding: EdgeInsets.only(right: 3.sp),
            child: Icon(
              checked ? Icons.check_circle : Icons.circle_outlined,
              size: 20,
              color: Colors.white,
            ),
          ),
        );
      },
    ),
    // bulleted list block
    BulletedListBlockKeys.type: BulletedListBlockComponentBuilder(
      configuration: configuration,
      // iconBuilder: (context, node) {
      //   return const Icon(
      //     Icons.circle,
      //     size: 20,
      //     color: Colors.green,
      //   );
      // },
    ),
    // quote block
    QuoteBlockKeys.type: QuoteBlockComponentBuilder(
      configuration: configuration,
    ),
    // divider block
    DividerBlockKeys.type: DividerBlockComponentBuilder(
      configuration: configuration,
      lineColor: Get.theme.colorScheme.secondaryContainer,
    ),
  };
}
