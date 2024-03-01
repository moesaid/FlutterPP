import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? hasBackButton;
  final String? title;
  final VoidCallback? onBack;

  const BuildAppBar({
    super.key,
    this.title,
    this.onBack,
    this.hasBackButton,
  });

  @override
  Size get preferredSize => const Size.fromHeight(30);

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isWindows) {
      return DragToMoveArea(
        child: _BuildAppBar(
          preferredSize: preferredSize,
          hasBackButton: hasBackButton,
          onBack: onBack,
          title: title,
        ),
      );
    }

    return _BuildAppBar(
      preferredSize: preferredSize,
      hasBackButton: hasBackButton,
      onBack: onBack,
      title: title,
    );
  }
}

class _BuildAppBar extends StatelessWidget {
  const _BuildAppBar({
    super.key,
    required this.preferredSize,
    required this.hasBackButton,
    required this.onBack,
    required this.title,
  });

  final Size preferredSize;
  final bool? hasBackButton;
  final VoidCallback? onBack;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      title: SizedBox(
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (hasBackButton != null && hasBackButton!)
              SizedBox(
                height: preferredSize.height,
                width: 0,
                child: VerticalDivider(color: Colors.grey.withOpacity(0.35)),
              ),
            if (hasBackButton != null && hasBackButton!)
              InkWell(
                onTap: onBack ?? () => Get.back(),
                child: Container(
                  height: preferredSize.height,
                  width: preferredSize.height,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: Get.theme.colorScheme.secondary,
                    size: 15,
                  ),
                ),
              ),
            SizedBox(
              height: preferredSize.height,
              width: 0,
              child: VerticalDivider(color: Colors.grey.withOpacity(0.35)),
            ),
            Expanded(
              child: Center(
                child: Text(
                  title ?? 'title',
                  style: Get.textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      leading: const SizedBox.shrink(),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 0.2),
          ),
        ),
      ),
    );
  }
}
