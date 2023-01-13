import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildAppFlowyHeader extends StatelessWidget {
  const BuildAppFlowyHeader({
    Key? key,
    required this.appFlowyController,
    required this.columnData,
  }) : super(key: key);

  final AppFlowyBoardController appFlowyController;
  final AppFlowyGroupData columnData;

  @override
  Widget build(BuildContext context) {
    return AppFlowyGroupHeader(
      height: 50,
      moreIcon: const Icon(Icons.more_vert, size: 20),
      onMoreButtonClick: () {
        print('More button clicked on ${columnData.id}');
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

Widget _buildCard(AppFlowyGroupItem item) {
  if (item is TextItem) {
    return RichTextCard(item: item.s);
  }

  if (item is RichTextItem) {
    return RichTextCard(item: item.title);
  }

  throw UnimplementedError();
}
