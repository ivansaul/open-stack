import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:openstack/src/features/posts/domain/post.dart';
import 'package:openstack/src/features/posts/domain/vote.dart';
import 'package:openstack/src/features/posts/presentation/widgets/tags_view.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';
import 'package:openstack/src/shared/widgets/filled_icon_count_button.dart';
import 'package:openstack/src/shared/widgets/vertical_divider.dart';
import 'package:openstack/src/theme/app_icons.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    required this.post,
    required this.onVote,
    this.onTapCard,
    this.onTapComment,
  });

  final PostModel post;
  final void Function()? onTapCard;
  final void Function(VoteType voteType)? onVote;
  final void Function()? onTapComment;

  @override
  Widget build(BuildContext context) {
    final author = post.author;
    return GestureDetector(
      onTap: onTapCard,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: context.colors.brandWhite,
          border: Border.all(
            color: context.colors.greyGrey250,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              dense: true,
              iconColor: context.colors.brandBlueDeep,
              visualDensity: VisualDensity.standard,
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: context.colors.greyGrey250,
                backgroundImage: NetworkImage(
                  author?.avatar ?? '', // TODO: improve default value
                ),
              ),
              title: Text(
                author?.name ?? '', // TODO: improve default value
                style: context.textTheme.body1Bold
                    .tsColor(context.colors.brandBlack),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              subtitle: Text(
                '8m read time ● Jan 19',
                style: context.textTheme.body2Medium,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      AppIcons.export_outline,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      AppIcons.more_outline,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              style: context.textTheme.heading3Bold,
              post.title ?? '', // TODO: improve default value
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(10),
            TagsView(
              tags: post.tags,
            ),
            const Gap(10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                post.image ?? '', // TODO: improve default value
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            const Gap(10),
            _ButtonsView(
              post: post,
              onVote: onVote,
              onTapCard: onTapCard,
              onTapComment: onTapComment,
            ),
          ],
        ),
      ),
    );
  }
}

class _ButtonsView extends StatelessWidget {
  const _ButtonsView({
    required this.post,
    this.onTapCard,
    this.onVote,
    this.onTapComment,
  });

  final PostModel post;
  final void Function()? onTapCard;
  final void Function(VoteType voteType)? onVote;
  final void Function()? onTapComment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.colors.greyGrey100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FilledIconCountButton(
                count: post.numUpVotes,
                isSelected: post.upVoted,
                icon: AppIcons.like_outline,
                selectedIcon: AppIcons.like_bold,
                selectedIconColor: context.colors.generalGreen,
                onPressed: () => onVote?.call(VoteType.up),
              ),
              const DividerVertical(),
              FilledIconCountButton(
                isSelected: post.downVoted,
                icon: AppIcons.dislike_outline,
                selectedIcon: AppIcons.dislike_bold,
                selectedIconColor: context.colors.generalRed,
                onPressed: () => onVote?.call(VoteType.down),
              ),
            ],
          ),
        ),
        FilledIconCountButton(
          icon: AppIcons.message_outline,
          count: post.numComments,
          onPressed: onTapComment,
        ),
        FilledIconCountButton(
          isSelected: false,
          icon: AppIcons.archive_outline,
          selectedIconColor: context.colors.generalOrange,
          selectedIcon: AppIcons.archive_bold,
          onPressed: () {},
        ),
        FilledIconCountButton(
          icon: AppIcons.send_2_outline,
          onPressed: () {},
        ),
      ],
    );
  }
}
