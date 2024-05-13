import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:openstack/src/features/auth/presentation/controllers/logout_controller.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/widgets/filled_button_decorated.dart';
import 'package:openstack/src/shared/widgets/outline_button_decorated.dart';

class LogoutModalSheet extends ConsumerWidget {
  const LogoutModalSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoutController = ref.watch(logoutControllerProvider);
    final isLoading = logoutController.isLoading;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Are you sure you want to logout?',
            style: context.textTheme.heading3Bold,
          ),
          const Gap(20),
          FilledButtonDecorated(
            isLoading: isLoading,
            title: 'Logout',
            onPressed: () =>
                ref.read(logoutControllerProvider.notifier).logout(),
          ),
          const Gap(10),
          OutlineButtonDecorated(
            title: 'Cancel',
            onPressed: () => context.pop(),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
