import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/theme/app_icons.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final void Function(int index) onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30, right: 10, left: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: context.colors.brandBackground,
          boxShadow: [
            BoxShadow(
              color: (context.brightness == Brightness.dark)
                  ? Colors.black87
                  : Colors.black.withOpacity(0.7),
              blurRadius: 25,
              spreadRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          clipBehavior: Clip.hardEdge,
          color: Colors.transparent,
          child: BottomBarFloating(
            iconSize: 20,
            titleStyle: context.textTheme.bodyOverlineRegular,
            borderRadius: BorderRadius.circular(20),
            items: _getItems(currentIndex),
            backgroundColor: context.colors.brandWhite,
            color: context.colors.brandBlueDeep,
            colorSelected: context.colors.brandBlack,
            indexSelected: currentIndex,
            paddingVertical: 12,
            onTap: onDestinationSelected,
          ),
        ),
      ),
    );
  }

  List<TabItem> _getItems(int index) {
    return [
      TabItem(
        icon: index == 0 ? AppIcons.home_bold : AppIcons.home_outline,
        title: 'Home',
      ),
      TabItem(
        icon: index == 1 ? AppIcons.user_edit_bold : AppIcons.user_edit_outline,
        title: 'Profile',
      ),
    ];
  }
}
