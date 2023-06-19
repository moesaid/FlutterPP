import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final VoidCallback? onBack;

  const BuildAppBar({
    super.key,
    this.title,
    this.onBack,
  });

  @override
  Size get preferredSize => const Size.fromHeight(30);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: preferredSize.height,
      title: SizedBox(
        width: double.infinity,
        // color: Colors.red,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: preferredSize.height,
              width: 0,
              child: VerticalDivider(color: Colors.grey.withOpacity(0.35)),
            ),
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
