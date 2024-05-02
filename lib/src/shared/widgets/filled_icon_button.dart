import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';

class FilledIconButton extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final String? label;
  final IconData? selectedIcon;
  final Color? iconColor;
  final Color? selectedIconColor;
  final double borderRadius;
  final void Function()? onPressed;
  const FilledIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.label,
    this.isSelected = false,
    this.selectedIcon,
    this.iconColor,
    this.selectedIconColor,
    this.borderRadius = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        backgroundColor: context.colors.greyGrey100,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      onPressed: onPressed,
      icon: Row(
        children: [
          if (label != null) ...[
            Text(label!, style: context.textTheme.body2Semibold),
            const Gap(5),
          ],
          Icon(
            icon,
            color: iconColor,
          ),
        ],
      ),
      isSelected: isSelected,
      selectedIcon: Icon(
        selectedIcon ?? icon,
        color: selectedIconColor,
      ),
    );
  }
}
