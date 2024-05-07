import 'package:flutter/material.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';
import 'package:openstack/src/shared/widgets/loading_dots.dart';

class FilledButtonDecorated extends StatelessWidget {
  const FilledButtonDecorated({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
    this.style,
    this.width,
    this.height = 45,
    this.borderRadius = 15,
    this.isLoading = false,
  });

  final String title;
  final Function()? onPressed;
  final Color? color;
  final TextStyle? style;
  final double? width;
  final double? height;
  final double borderRadius;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: color ?? context.colors.generalRed,
        foregroundColor: Colors.black.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        disabledBackgroundColor: color ?? context.colors.generalRed,
      ),
      onPressed: isLoading ? null : onPressed,
      child: Container(
        alignment: Alignment.center,
        width: width,
        height: height,
        child: isLoading
            ? const LoadingDots()
            : Text(
                title,
                style: style ??
                    context.textTheme.body1Bold
                        .tsColor(context.colors.brandWhite),
              ),
      ),
    );
  }
}
