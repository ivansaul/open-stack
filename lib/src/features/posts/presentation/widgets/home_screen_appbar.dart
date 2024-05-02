import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/widgets/app_logo.dart';
import 'package:openstack/src/theme/app_icons.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: context.colors.brandBackground,
      title: const AppLogo(height: 20),
      centerTitle: false,
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(AppIcons.candle_2_outline),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(AppIcons.notification_outline),
        ),
        const Gap(5),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
