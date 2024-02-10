import 'package:flutter/material.dart';

class BuildCustomDropdown extends StatelessWidget {
  final Widget? child;
  final List<PopupMenuEntry<String>>? items;

  const BuildCustomDropdown({super.key, this.child, this.items});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showPopupMenu(context);
      },
      child: child ?? const Icon(Icons.more_vert_sharp),
    );
  }

  void _showPopupMenu(BuildContext context) async {
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(
          button.size.bottomLeft(Offset.zero),
          ancestor: overlay,
        ),
        button.localToGlobal(
          button.size.bottomRight(Offset.zero),
          ancestor: overlay,
        ),
      ),
      Offset.zero & overlay.size,
    );

    final result = await showMenu<String>(
      context: context,
      position: position,
      items: items ??
          [
            const PopupMenuItem<String>(
              value: 'Option 1',
              child: ListTile(
                title: Text('Option 1'),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'Option 2',
              child: ListTile(
                title: Text('Option 2'),
              ),
            ),
            const PopupMenuItem<String>(
              value: 'Option 3',
              child: ListTile(
                title: Text('Option 3'),
              ),
            ),
          ],
    );

    // Handle the selected value
    if (result != null) {
      print('Selected value: $result');
    }
  }
}
