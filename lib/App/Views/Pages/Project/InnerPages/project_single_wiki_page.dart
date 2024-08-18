import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:emojis/emoji.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:flutterpp/App/Controllers/Global/emoji_dialog_controller.dart';
import 'package:flutterpp/App/Controllers/Project/Single/project_single_wiki_controller.dart';
import 'package:flutterpp/App/Models/wiki_model.dart';
import 'package:flutterpp/App/Views/Global/build_custom_dropdown.dart';
import 'package:flutterpp/App/Views/Global/build_loading_or_empty_layout.dart';
import 'package:flutterpp/App/Views/Global/build_rename_dialog.dart';
import 'package:flutterpp/App/Views/Global/buiuld_dialog.dart';
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
        return Scaffold(
          body: BuildLoadingOrEmptyLayout(
            isLoading: controller.isLoading,
            isEmpty: controller.wikis.isEmpty,
            child: Container(
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
                editorState: controller.editorState,
                textDirection: TextDirection.ltr,
                editorScrollController: controller.editorScrollController,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Row(
                      children: [
                        BuildProjectSingleWikiSidebar(controller: controller),
                        Expanded(
                          child: AppFlowyEditor(
                            autoFocus: true,
                            editorState: controller.editorState,
                            editorStyle: customizeEditorStyle(),
                            blockComponentBuilders: customBuilder(),
                            commandShortcutEvents: [
                              ...standardCommandShortcutEvents,
                              CommandShortcutEvent(
                                key: 'ctrl+s',
                                command:
                                    GetPlatform.isWindows ? 'ctrl+s' : 'cmd+s',
                                handler: (EditorState editorState) {
                                  controller.updateWikiDoc();
                                  return KeyEventResult.handled;
                                },
                                getDescription: () {
                                  return 'Save';
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: FilledButton(
                        onPressed: () => controller.updateWikiDoc(),
                        child: const Text('Save'),
                      ),
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

class BuildProjectSingleWikiSidebar extends StatelessWidget {
  const BuildProjectSingleWikiSidebar({
    super.key,
    required this.controller,
  });

  final ProjectSingleWikiController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width * 0.15,
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.primaryContainer,
        border: Border(
          right: BorderSide(
            color: Get.theme.colorScheme.secondaryContainer,
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: controller.wikis.length,
              itemBuilder: (context, index) {
                final WikiModel wiki = controller.wikis[index];
                return InkWell(
                  onTap: () => controller.changeActiveWiki(wiki),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    padding: const EdgeInsets.all(10),
                    color: controller.activeWiki.id == wiki.id
                        ? Get.theme.colorScheme.secondaryContainer
                        : Get.theme.colorScheme.primaryContainer,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => showDialog(
                            context: context,
                            builder: (__) => BuildEmojiDialog(
                              onEmojiSelected: (val) async {
                                await controller.updateWikiIconOrTitle(
                                  wiki: wiki,
                                  icon: val,
                                );
                                Get.back();
                              },
                            ),
                          ),
                          child: Text(wiki.icon ?? '📄'),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          wiki.title?.capitalize! ?? '',
                          style: Get.theme.textTheme.labelMedium,
                        ),
                        const Spacer(),
                        BuildCustomDropdown(
                          items: [
                            PopupMenuItem<String>(
                              value: 'rename',
                              onTap: () => showDialog(
                                context: context,
                                builder: (_) => BuildRenameDialog(
                                  title: wiki.title ?? '',
                                  callback: (val) {
                                    controller.updateWikiIconOrTitle(
                                      wiki: wiki,
                                      title: val,
                                    );
                                  },
                                ),
                              ),
                              mouseCursor: SystemMouseCursors.click,
                              child: const Text('Rename'),
                            ),
                            PopupMenuItem<String>(
                              value: 'duplicate',
                              onTap: () => controller.duplicateWiki(wiki),
                              mouseCursor: SystemMouseCursors.click,
                              child: const Text('Duplicate'),
                            ),
                            PopupMenuItem<String>(
                              value: 'delete',
                              onTap: () => controller.deleteWiki(wiki),
                              mouseCursor: SystemMouseCursors.click,
                              child: const Text('Delete'),
                            ),
                          ],
                          child: Icon(
                            Icons.more_vert_sharp,
                            size: 6.spa,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 0, thickness: 0.5),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () => controller.createNewPage(),
              style: TextButton.styleFrom(
                textStyle: Get.theme.textTheme.labelMedium,
                foregroundColor: Get.theme.colorScheme.onSurface,
              ),
              child: Row(
                children: [
                  const Icon(Icons.add_rounded, size: 18),
                  const SizedBox(width: 5),
                  Text('new page'.capitalize!),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BuildEmojiDialog extends StatelessWidget {
  final String? controllerTag;
  final Function(String)? onEmojiSelected;

  const BuildEmojiDialog({
    super.key,
    this.controllerTag,
    this.onEmojiSelected,
  });

  @override
  Widget build(BuildContext context) {
    // get all emojis groups
    List<EmojiGroup> groups = EmojiGroup.values;

    return GetBuilder<EmojiDialogController>(
      init: EmojiDialogController(),
      tag: controllerTag,
      initState: (_) {},
      builder: (_) {
        return BuildDefultDialog(
          child: Column(
            children: [
              SizedBox(
                height: 35,
                child: ListView.separated(
                  itemCount: groups.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(width: 10);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    final group = groups[index];

                    return InkWell(
                      onTap: () => _.changeActiveGroup(group),
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          color: _.activeGroup.name == group.name
                              ? Get.theme.colorScheme.primary
                              : Get.theme.colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            group.name != 'flags'
                                ? Emoji.byGroup(group).first.char
                                : Emojis.flagPalestinianTerritories,
                            style: Get.theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Divider(height: 20.spa, thickness: 0.5),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 10,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: _.emojiList.length,
                  itemBuilder: (context, index) {
                    final emoji = _.emojiList[index];
                    return InkWell(
                      onTap: () {
                        onEmojiSelected?.call(emoji.char);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Get.theme.colorScheme.secondaryContainer,
                        ),
                        child: Center(
                          child: Text(
                            emoji.char,
                            style: Get.theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

EditorStyle customizeEditorStyle() {
  return EditorStyle(
    padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
    cursorColor: Get.theme.colorScheme.onSurface,
    selectionColor: Colors.red.withOpacity(0.3),
    textStyleConfiguration: TextStyleConfiguration(
      text: TextStyle(
        color: Get.theme.colorScheme.onSurface,
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
            color: Get.theme.colorScheme.onSurface,
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
          color: Get.theme.colorScheme.onSurface.withOpacity(
            value ? 0.5 : 1,
          ),
          fontStyle: value ? FontStyle.italic : FontStyle.normal,
          decoration: value ? TextDecoration.lineThrough : null,
        );
      },
      iconBuilder: (context, node, fun) {
        final checked = node.attributes[TodoListBlockKeys.checked] as bool;
        return InkWell(
          onTap: () => node.updateAttributes(
            {TodoListBlockKeys.checked: !checked},
          ),
          child: Padding(
            padding: EdgeInsets.only(right: 3.spa),
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
