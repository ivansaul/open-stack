import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';
import 'package:openstack/src/theme/app_icons.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.colors.brandWhite,
        border: Border.all(
          color: context.colors.greyGrey250,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            dense: true,
            iconColor: context.colors.brandBlueDeep,
            visualDensity: VisualDensity.standard,
            contentPadding: EdgeInsets.zero,
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                width: 50,
                height: 50,
                'http://127.0.0.1:8090/api/files/_pb_users_auth_/w092au2zvhtooat/500_SADZyNquAB.jpeg',
                fit: BoxFit.contain,
              ),
            ),
            title: Text(
              'George Smith',
              style: context.textTheme.body1Bold
                  .tsColor(context.colors.brandBlack),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            subtitle: Text(
              '@georgesmith  ●  2 months ago',
              style: context.textTheme.body2Medium,
            ),
          ),
          const Gap(10),
          Text(
            'Very interesting. Thank you for article 🫠',
            style: context.textTheme.body1Medium
                .tsColor(context.colors.brandBlack),
          ),
          const Gap(20),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(AppIcons.like_outline),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(AppIcons.dislike_outline),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(AppIcons.message_outline),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(AppIcons.send_2_outline),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(AppIcons.more_outline),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  '2 Upvotes',
                  style: context.textTheme.body2Medium,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
