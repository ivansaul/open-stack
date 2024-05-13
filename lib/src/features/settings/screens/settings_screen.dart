import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:openstack/src/features/auth/presentation/widgets/logout_modal_sheet.dart';
import 'package:openstack/src/features/settings/widgets/section_list_tile.dart';
import 'package:openstack/src/router/app_router.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/theme/app_icons.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: false,
        title: Text(
          'Settings',
          style: context.textTheme.heading3SemiBold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: const [
            _ProfileSectionView(),
            Gap(20),
            _ManageSectionView(),
            Gap(20),
            _SupportSectionView(),
          ],
        ),
      ),
    );
  }
}

class _ProfileSectionView extends StatelessWidget {
  const _ProfileSectionView();

  @override
  Widget build(BuildContext context) {
    return SectionListTile(
      title: 'Profile',
      items: [
        SectionListTileItem(
          leadingIcon: AppIcons.edit_2_outline,
          title: 'Edit Profile',
          onTap: () => context.pushNamed(AppRoute.editProfile.name),
        ),
        SectionListTileItem(
          leadingIcon: AppIcons.logout_outline,
          title: 'Logout',
          onTap: () async {
            showModalBottomSheet(
              context: context,
              builder: (_) => const LogoutModalSheet(),
            );
          },
        ),
      ],
    );
  }
}

class _ManageSectionView extends StatelessWidget {
  const _ManageSectionView();

  @override
  Widget build(BuildContext context) {
    return SectionListTile(
      title: 'Manage',
      items: [
        SectionListTileItem(
          leadingIcon: AppIcons.category_outline,
          title: 'Customize',
          onTap: () {},
        ),
        SectionListTileItem(
          leadingIcon: AppIcons.more_outline,
          title: 'Other Settings',
          onTap: () {},
        ),
      ],
    );
  }
}

class _SupportSectionView extends StatelessWidget {
  const _SupportSectionView();

  @override
  Widget build(BuildContext context) {
    return SectionListTile(
      title: 'Support',
      items: [
        SectionListTileItem(
          leadingIcon: AppIcons.document_text_outline,
          title: 'Docs',
          onTap: () {},
        ),
        SectionListTileItem(
          leadingIcon: AppIcons.messages_outline,
          title: 'Feedback',
          onTap: () {},
        ),
        SectionListTileItem(
          leadingIcon: AppIcons.code_outline,
          title: 'Suggest new features',
          onTap: () {},
        ),
      ],
    );
  }
}
