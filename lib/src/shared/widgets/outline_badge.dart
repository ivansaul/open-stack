import 'package:flutter/material.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';

class OutlineBadge extends StatelessWidget {
  final String tag;
  final double borderRadius;
  final String hashtag;
  final void Function()? onTap;
  const OutlineBadge({
    super.key,
    required this.tag,
    this.borderRadius = 7.0,
    this.hashtag = "#",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.hardEdge,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.colors.greyGrey200,
            ),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Text(
            "$hashtag$tag",
            style: context.textTheme.bodyCaptionRegular
                .tsColor(context.colors.brandBlueDeep),
          ),
        ),
      ),
    );
  }
}
