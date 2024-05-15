import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openstack/src/features/auth/domain/user.dart';
import 'package:openstack/src/features/auth/presentation/providers/auth_state_changes_provider.dart';
import 'package:openstack/src/features/posts/presentation/widgets/post_card.dart';
import 'package:openstack/src/features/profile/presentation/providers/my_posts_providers.dart';
import 'package:openstack/src/features/profile/presentation/widgets/profile_header_delegate.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/widgets/async_value_widgets.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(authStateChangesProvider);
    return ScaffoldAsyncValueWidget(
      asyncValue: currentUserAsync,
      data: (user) => _ScaffoldView(
        user: user,
      ),
    );
  }
}

class _ScaffoldView extends StatelessWidget {
  const _ScaffoldView({
    required this.user,
  });

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: context.colors.brandBackground,
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverPersistentHeader(
                  pinned: true,
                  delegate: ProfileHeaderDelegate(
                    user: user,
                    tabs: const [
                      Text('Posts'),
                      Text('Upvoted'),
                      Text('Bookmarked'),
                    ],
                  ),
                ),
              ];
            },
            body: const TabBarView(
              children: [
                _MyPostsView(),
                _UpVotedPostsView(),
                _BookmarkedPostsView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MyPostsView extends HookConsumerWidget {
  const _MyPostsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final asyncValue = ref.watch(fetchMyPostsProvider);
    return AsyncValueWidget(
      asyncValue: asyncValue,
      data: (posts) {
        return RefreshIndicator(
          onRefresh: () async => {
            ref.invalidate(fetchMyPostsProvider),
          },
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostCard(post: post);
            },
          ),
        );
      },
    );
  }
}

class _UpVotedPostsView extends HookConsumerWidget {
  const _UpVotedPostsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final asyncValue = ref.watch(fetchMyUpVotedPostsProvider);
    return AsyncValueWidget(
      asyncValue: asyncValue,
      data: (posts) {
        return RefreshIndicator(
          onRefresh: () async => {
            ref.invalidate(fetchMyUpVotedPostsProvider),
          },
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostCard(post: post);
            },
          ),
        );
      },
    );
  }
}

class _BookmarkedPostsView extends HookConsumerWidget {
  const _BookmarkedPostsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useAutomaticKeepAlive();
    final asyncValue = ref.watch(fetchMyBookmarkedPostsProvider);
    return AsyncValueWidget(
      asyncValue: asyncValue,
      data: (posts) {
        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(fetchMyBookmarkedPostsProvider);
          },
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return PostCard(post: post);
            },
          ),
        );
      },
    );
  }
}
