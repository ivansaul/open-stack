import 'package:flutter/material.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';
import 'package:openstack/src/shared/widgets/loading_dots.dart';

class OutlineButtonDecorated extends StatelessWidget {
  const OutlineButtonDecorated({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
    this.style,
    this.width = double.infinity,
    this.height = 45,
    this.borderRadius = 15,
    this.isLoading = false,
  });

  final String title;
  final Function()? onPressed;
  final Color? color;
  final TextStyle? style;
  final double width;
  final double height;
  final double borderRadius;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        minimumSize: Size(width, height),
        foregroundColor: Colors.black.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        side: BorderSide(
          color: context.colors.brandBlack,
        ),
      ),
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const LoadingDots()
          : Text(
              title,
              style: style ??
                  context.textTheme.body1Bold
                      .tsColor(context.colors.brandBlack),
            ),
    );
  }
}
