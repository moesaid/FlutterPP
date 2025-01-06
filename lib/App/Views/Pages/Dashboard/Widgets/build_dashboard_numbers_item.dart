import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:sizer/sizer.dart';

class BuildDashboardNumbersItem extends StatelessWidget {
  const BuildDashboardNumbersItem({
    super.key,
    this.numbers,
    this.title,
    this.subtitle,
    this.onTap,
    this.icon,
    this.bgColor,
  });

  final int? numbers;
  final String? title, subtitle;
  final VoidCallback? onTap;
  final HeroIcons? icon;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.spa),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.spa),
        color: Get.theme.colorScheme.primaryContainer,
        border: Border.all(
          width: 1,
          color: Get.theme.colorScheme.secondaryContainer,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(2.5.spa),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        bgColor ?? Colors.indigo,
                        bgColor?.withValues(alpha: 0.5) ??
                            Colors.indigo.withValues(alpha: 0.5),
                      ],
                    ),
                  ),
                  child: HeroIcon(
                    size: 7.spa,
                    icon ?? HeroIcons.commandLine,
                    style: HeroIconStyle.solid,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        title?.capitalize ?? 'Title',
                        style: TextStyle(
                          fontSize: context.width * 0.01,
                          fontWeight: FontWeight.w400,
                          color: Get.theme.colorScheme.onSurface.withValues(
                            alpha: 0.3,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        numbers?.toString() ?? '0',
                        style: TextStyle(
                          fontSize: context.width * 0.012,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            subtitle?.capitalize ?? '',
            style: TextStyle(
              fontSize: context.width * 0.012,
            ),
          ),
        ],
      ),
    );
  }
}
