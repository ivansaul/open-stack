import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:openstack/src/features/posts/domain/post_model.dart';
import 'package:openstack/src/features/posts/domain/reaction_model.dart';
import 'package:openstack/src/features/posts/presentation/controllers/post_controller.dart';
import 'package:openstack/src/features/posts/presentation/providers/post_providers.dart';
import 'package:openstack/src/features/posts/presentation/widgets/comment_card.dart';
import 'package:openstack/src/features/posts/presentation/widgets/tags_view.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';
import 'package:openstack/src/shared/widgets/async_value_widgets.dart';
import 'package:openstack/src/shared/widgets/filled_icon_button.dart';
import 'package:openstack/src/shared/widgets/filled_icon_count_button.dart';
import 'package:openstack/src/theme/app_icons.dart';

class PostDetailScreen extends ConsumerWidget {
  final String postId;

  const PostDetailScreen({
    super.key,
    required this.postId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postAsync = ref.watch(watchPostProvider(postId));
    return ScaffoldAsyncValueWidget<PostModel>(
      asyncValue: postAsync,
      data: (post) => _ScaffoldView(post: post),
    );
  }
}

class _ScaffoldView extends ConsumerWidget {
  final PostModel post;

  const _ScaffoldView({
    required this.post,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reactionsInfo =
        ref.watch(watchPostReactionsInfoProvider(post.id)).valueOrNull;
    final bookmarksInfo =
        ref.watch(watchPostBookmarksInfoProvider(post.id)).valueOrNull;
    return Scaffold(
      backgroundColor: context.colors.brandBackground,
      appBar: const _AppBarView(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Text(
              post.title,
              style: context.textTheme.heading2Bold,
            ),
            const Gap(20),
            Text(
              post.summary!,
              style: context.textTheme.body1Medium
                  .tsColor(context.colors.brandBlack),
            ),
            const Gap(10),
            TagsView(
              tags: post.tags ?? [],
            ),
            const Gap(20),
            Text(
              '8m read time ● Jan 19',
              style: context.textTheme.body2Medium,
            ),
            const Gap(20),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                post.image!,
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            const Gap(20),
            Text(
              '${reactionsInfo?.numUpVotes ?? 0} Votes    0 Comments',
              style: context.textTheme.body2Medium,
            ),
            const Gap(20),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: context.colors.brandWhite,
                border: Border.all(
                  color: context.colors.greyGrey250,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FilledIconCountButton(
                    isSelected: reactionsInfo?.type == ReactionType.up,
                    icon: AppIcons.like_outline,
                    selectedIcon: AppIcons.like_bold,
                    selectedIconColor: context.colors.generalGreen,
                    onPressed: () => onReaction(ref, post.id, ReactionType.up),
                  ),
                  FilledIconCountButton(
                    isSelected: reactionsInfo?.type == ReactionType.down,
                    icon: AppIcons.dislike_outline,
                    selectedIcon: AppIcons.dislike_bold,
                    selectedIconColor: context.colors.generalRed,
                    onPressed: () =>
                        onReaction(ref, post.id, ReactionType.down),
                  ),
                  FilledIconCountButton(
                    icon: AppIcons.message_outline,
                    onPressed: () {},
                  ),
                  FilledIconCountButton(
                    isSelected: bookmarksInfo?.isBookmarked ?? false,
                    icon: AppIcons.archive_outline,
                    selectedIconColor: context.colors.generalOrange,
                    selectedIcon: AppIcons.archive_bold,
                    onPressed: () =>
                        onTapBookmarkIcon(ref, bookmarksInfo?.isBookmarked),
                  ),
                  FilledIconCountButton(
                    icon: AppIcons.send_2_outline,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const Gap(20),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: CommentCard(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void onReaction(WidgetRef ref, String postId, ReactionType reactionType) {
    ref.read(postControllerProvider.notifier).onReaction(
          postId: postId,
          reactionType: reactionType,
        );
  }

  void onTapBookmarkIcon(WidgetRef ref, bool? isBookmarked) {
    if (isBookmarked == null) return;
    if (isBookmarked) {
      ref.read(postControllerProvider.notifier).deleteBookmark(
            postId: post.id,
          );
    } else {
      ref.read(postControllerProvider.notifier).addBookmark(
            postId: post.id,
          );
    }
  }
}

class _AppBarView extends StatelessWidget implements PreferredSizeWidget {
  const _AppBarView();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: context.colors.brandBackground,
      actions: [
        FilledIconButton(
          icon: AppIcons.export_outline,
          label: "Read Post",
          onPressed: () {},
        ),
        const Gap(10),
        FilledIconButton(
          icon: AppIcons.more_outline,
          onPressed: () {},
        ),
        const Gap(20),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
