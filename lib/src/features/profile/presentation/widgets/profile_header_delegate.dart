// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:openstack/src/features/auth/domain/user.dart';
import 'package:openstack/src/features/profile/presentation/widgets/avatar_cover_widget.dart';
import 'package:openstack/src/features/profile/presentation/widgets/avatar_widget.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';
import 'package:openstack/src/shared/widgets/filled_icon_button.dart';
import 'package:openstack/src/shared/widgets/outline_button_decorated.dart';
import 'package:openstack/src/theme/app_icons.dart';

const double _titleHeight = 50;
const double _bodyHeight = 250;
const double _bioHeight = 20;
const double _tabBarHeight = 40;

const double _minHeaderExtent = _titleHeight + _tabBarHeight;
const double _maxHeaderExtent = _titleHeight + _bodyHeight + _tabBarHeight;

class ProfileHeaderDelegate extends SliverPersistentHeaderDelegate {
  ProfileHeaderDelegate({
    required this.user,
    required this.tabs,
  });

  final UserModel? user;
  final List<Widget> tabs;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final percentage = shrinkOffset / _maxHeaderExtent;
    final top = percentage > 0.3
        ? (-_titleHeight + (percentage - 0.3) * _maxHeaderExtent)
            .clamp(-_titleHeight, 0)
            .toDouble()
        : -_titleHeight;

    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            bottom: _titleHeight,
            child: _HeaderBody(user: user),
          ),
          Positioned(
            top: top,
            child: _HeaderPinedTitle(user: user),
          ),
          _HeaderTabBar(tabs),
        ],
      ),
    );
  }

  @override
  double get maxExtent {
    return user?.bio == null ? _maxHeaderExtent : _maxHeaderExtent + _bioHeight;
  }

  @override
  double get minExtent => _minHeaderExtent;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}

class _HeaderBody extends StatelessWidget {
  const _HeaderBody({
    required this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: context.colors.brandBackground,
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Profile',
                style: context.textTheme.heading3SemiBold,
              ),
              const Spacer(),
              FilledIconButton(
                icon: AppIcons.link_outline,
                onPressed: () async {},
              ),
              const Gap(10),
              FilledIconButton(
                icon: AppIcons.settings_2_outline,
                onPressed: () {},
              ),
            ],
          ),
          const Gap(10),
          AvatarAndCover(
            avatarUrl: user?.avatar,
            coverUrl: null,
          ),
          const Gap(10),
          if (user?.name != null)
            Text(
              user!.name!,
              style: context.textTheme.heading3Bold,
            ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "@${user?.username ?? ''}",
                  style: context.textTheme.bodyCaptionRegular
                      .tsColor(context.colors.brandBlack),
                ),
                TextSpan(
                  text: '   •   ',
                  style: context.textTheme.bodyOverlineRegular,
                ),
                TextSpan(
                  text: 'Joined April 2024',
                  style: context.textTheme.bodyOverlineRegular,
                ),
              ],
            ),
          ),
          const Gap(10),
          (user?.bio != null)
              ? Text(
                  user?.bio ?? '',
                  style: context.textTheme.body2Regular.tsColor(
                    context.colors.brandBlack,
                  ),
                )
              : OutlineButtonDecorated(
                  title: 'Add Bio',
                  width: 45,
                  height: 40,
                  onPressed: () {},
                ),
        ],
      ),
    );
  }
}

class _HeaderPinedTitle extends StatelessWidget {
  const _HeaderPinedTitle({
    required this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: context.colors.brandBackground,
      width: context.width,
      child: Row(
        children: [
          AvatarWidget(
            height: _titleHeight * 0.7,
            borderRadius: 10,
            url: user?.avatar,
          ),
          const Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.name ?? '',
                style: context.textTheme.body2Semibold.tsColor(
                  context.colors.brandBlack,
                ),
              ),
              Text(
                "@${user?.username ?? ''}",
                style: context.textTheme.bodyCaptionRegular,
              ),
            ],
          ),
          const Spacer(),
          FilledIconButton(
            icon: AppIcons.link_outline,
            onPressed: () async {},
          ),
          const Gap(10),
          FilledIconButton(
            icon: AppIcons.settings_2_outline,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

class _HeaderTabBar extends StatelessWidget {
  const _HeaderTabBar(this.tabs);

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.brandBackground,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TabBar(
            tabAlignment: TabAlignment.center,
            isScrollable: true,
            labelColor: context.colors.brandBlack,
            unselectedLabelColor: context.colors.brandBlueDeep,
            indicatorColor: context.colors.brandBlack,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 3.0,
                color: context.colors.brandBlack,
              ),
              insets: const EdgeInsets.symmetric(horizontal: 10.0),
              borderRadius: BorderRadius.circular(10),
            ),
            labelPadding: const EdgeInsets.only(
              left: 0,
              right: 20,
              bottom: 10,
              top: 10,
            ),
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            tabs: tabs,
          ),
          Divider(
            height: 0,
            color: context.colors.brandBlueDeep.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
