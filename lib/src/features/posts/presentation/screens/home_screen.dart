import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:openstack/src/features/posts/data/posts_repository_provider.dart';
import 'package:openstack/src/features/posts/domain/post_model.dart';
import 'package:openstack/src/features/posts/presentation/providers/post_providers.dart';
import 'package:openstack/src/features/posts/presentation/widgets/home_screen_appbar.dart';
import 'package:openstack/src/features/posts/presentation/widgets/post_card.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/widgets/async_value_widgets.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsync = ref.watch(watchPostsProvider);

    return ScaffoldAsyncValueWidget<List<PostModel>>(
      asyncValue: postsAsync,
      data: (posts) => _ScaffoldView(posts: posts),
    );
  }
}

class _ScaffoldView extends ConsumerWidget {
  const _ScaffoldView({
    required this.posts,
  });

  final List<PostModel> posts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: context.colors.brandBackground,
      appBar: const HomeScreenAppBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(postsRepositoryProvider);
          ref.invalidate(watchPostsProvider);
        },
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            final post = posts[index];
            return PostCard(
              post: post,
            );
          },
        ),
      ),
    );
  }
}
