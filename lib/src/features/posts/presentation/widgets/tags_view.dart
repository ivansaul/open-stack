import 'package:flutter/material.dart';
import 'package:openstack/src/shared/widgets/outline_badge.dart';

class TagsView extends StatelessWidget {
  final List<String> tags;
  final int limit;
  const TagsView({
    super.key,
    required this.tags,
    this.limit = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 10,
        runSpacing: 5,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        direction: Axis.horizontal,
        children: [
          ...tags.take(limit).map(
                (tag) => OutlineBadge(
                  tag: tag,
                  onTap: () {},
                ),
              ),
          if (tags.length > limit)
            OutlineBadge(
              tag: "${tags.length - limit} tags",
              hashtag: "+",
              onTap: () {},
            ),
        ],
      ),
    );
  }
}
