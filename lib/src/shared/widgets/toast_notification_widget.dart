import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';
import 'package:openstack/src/theme/app_icons.dart';
import 'package:openstack/src/utils/app_toast.dart';

class ToastNotificationWidget extends StatelessWidget {
  final EdgeInsets? margin;
  final EdgeInsets? contentPadding;
  final String message;
  final ToastType type;

  const ToastNotificationWidget({
    super.key,
    required this.message,
    required this.type,
    this.margin = const EdgeInsets.all(20),
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 10,
    ),
  });

  @override
  Widget build(BuildContext context) {
    final (iconData, iconColor) = switch (type) {
      ToastType.error => (AppIcons.warning_outlined, context.colors.generalRed),
    };
    return Container(
      margin: margin,
      clipBehavior: Clip.hardEdge,
      padding: contentPadding,
      decoration: BoxDecoration(
        color: context.colors.brandBackground,
        border: Border.all(
          color: context.colors.greyGrey200,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: iconColor,
            size: 25,
          ),
          const Gap(10),
          Expanded(
            child: Text(
              message,
              style: context.textTheme.body1Medium
                  .tsColor(context.colors.brandBlack),
            ),
          ),
        ],
      ),
    );
  }
}
