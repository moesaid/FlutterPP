import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';

class BuildAppbarPlatformButton extends StatelessWidget {
  final bool hover;
  final double size;
  final VoidCallback? onTap;
  final Color beforeHoverColor, afterHoverColor;
  final HeroIcons icon;
  const BuildAppbarPlatformButton({
    super.key,
    required this.hover,
    required this.size,
    this.onTap,
    required this.beforeHoverColor,
    required this.afterHoverColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        height: size,
        width: size,
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: hover ? afterHoverColor : beforeHoverColor,
        ),
        child: Visibility(
          visible: hover,
          child: HeroIcon(
            icon,
            size: 10,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
