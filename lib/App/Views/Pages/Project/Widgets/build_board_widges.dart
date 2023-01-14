import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

class BuildAppFlowyHeader extends StatelessWidget {
  const BuildAppFlowyHeader({
    Key? key,
    required this.appFlowyController,
    required this.columnData,
    required this.updateBoard,
  }) : super(key: key);

  final AppFlowyBoardController appFlowyController;
  final AppFlowyGroupData columnData;
  final Function(Map) updateBoard;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return AppFlowyGroupHeader(
      height: 50,
      moreIcon: const Icon(Icons.more_vert, size: 20),
      onMoreButtonClick: () {
        Get.defaultDialog(
          radius: 6,
          title: 'update board title'.capitalize!,
          titlePadding: const EdgeInsets.all(20),
          titleStyle: Get.textTheme.headline6,
          contentPadding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: 20,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormBuilder(
                key: formKey,
                child: FormBuilderTextField(
                  name: 'title',
                  decoration: InputDecoration(
                    labelText: 'title'.capitalize!,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                  ]),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.saveAndValidate()) {
                    Map data = {
                      'id': columnData.id,
                      'title': formKey.currentState!.value['title'],
                    };

                    await updateBoard(data);
                    Get.back();
                  }
                },
                child: const Text('Update'),
              )
            ],
          ),
        );
      },
      title: Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(columnData.headerData.groupName),
        ),
      ),
    );
  }
}

class BuildAppFlowyFooter extends StatelessWidget {
  final AppFlowyGroupData columnData;
  const BuildAppFlowyFooter({
    Key? key,
    required this.columnData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppFlowyGroupFooter(
      height: 50,
      icon: const Icon(Icons.add, size: 20),
      title: const Text('Add Card'),
      onAddButtonClick: () {
        // boardController.scrollToBottom(columnData.id);
        print('Add Card to :  ${columnData.id}');
      },
    );
  }
}

class TextItem extends AppFlowyGroupItem {
  final String s;
  TextItem(this.s);

  @override
  String get id => s;
}

class RichTextItem extends AppFlowyGroupItem {
  final String title;
  final String subtitle;

  RichTextItem({required this.title, required this.subtitle});

  @override
  String get id => title;
}

class RichTextCard extends StatelessWidget {
  final String item;
  const RichTextCard({
    required this.item,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.secondaryContainer,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
