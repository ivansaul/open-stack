import 'package:flutter/material.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';

class SectionListTile extends StatelessWidget {
  const SectionListTile({
    super.key,
    required this.items,
    this.title,
  });

  final String? title;
  final List<SectionListTileItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: context.textTheme.body2Semibold
                .tsColor(context.colors.brandBlack),
          ),
        ...items.map(
          (item) => ListTile(
            dense: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            leading: Icon(
              item.leadingIcon,
              size: 20,
              color: context.colors.brandBlueDeep,
            ),
            title: Text(
              item.title,
              style: context.textTheme.body1Regular,
            ),
            onTap: item.onTap,
          ),
        ),
      ],
    );
  }
}

class SectionListTileItem {
  const SectionListTileItem({
    required this.title,
    this.leadingIcon,
    this.onTap,
  });

  final String title;
  final IconData? leadingIcon;
  final void Function()? onTap;
}
