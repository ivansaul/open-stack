import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:openstack/src/features/auth/presentation/controllers/logout_controller.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';
import 'package:openstack/src/shared/widgets/filled_button_decorated.dart';
import 'package:openstack/src/theme/app_icons.dart';

class PostCardMoreOptionsModalSheet extends ConsumerWidget {
  const PostCardMoreOptionsModalSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoutController = ref.watch(logoutControllerProvider);
    final isLoading = logoutController.isLoading;
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            leading: Icon(
              AppIcons.edit_2_outline,
              size: 20,
              color: context.colors.brandBlueDeep,
            ),
            title: Text(
              'Edit Post',
              style: context.textTheme.body1Regular,
            ),
            onTap: () => context.pop(),
          ),
          ListTile(
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            leading: Icon(
              Icons.delete_outline_rounded, // Replace with custom icon
              size: 20,
              color: context.colors.brandBlueDeep,
            ),
            title: Text(
              'Delete Post',
              style: context.textTheme.body1Regular,
            ),
            onTap: () => context.pop(),
          ),
          const Gap(10),
          FilledButtonDecorated(
            color: context.colors.greyGrey250,
            style: context.textTheme.body1Bold
                .tsColor(context.colors.brandBlueDeep),
            isLoading: isLoading,
            title: 'Cancel',
            onPressed: context.pop,
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
