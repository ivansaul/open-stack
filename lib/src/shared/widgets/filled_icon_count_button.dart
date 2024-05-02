import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/numbers_extensions.dart';

class FilledIconCountButton extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final IconData? selectedIcon;
  final Color? iconColor;
  final Color? selectedIconColor;
  final int count;
  final double borderRadius;
  final void Function()? onPressed;
  const FilledIconCountButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.isSelected = false,
    this.selectedIcon,
    this.iconColor,
    this.selectedIconColor,
    this.count = 0,
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
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isSelected ? selectedIconColor : iconColor,
          ),
          if (count > 0) ...[
            const Gap(5),
            Text(
              count.compact(),
              style: context.textTheme.body2Semibold,
            ),
          ],
        ],
      ),
      isSelected: isSelected,
      selectedIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            selectedIcon ?? icon,
            color: selectedIconColor,
          ),
          if (count > 0) ...[
            const Gap(5),
            Text(
              count.compact(),
              style: context.textTheme.body2Semibold,
            ),
          ],
        ],
      ),
    );
  }
}
