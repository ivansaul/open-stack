import 'package:flutter/material.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';
import 'package:openstack/src/shared/extensions/text_style_extensions.dart';

class AuthFilledButton extends StatelessWidget {
  final String text;
  final double width;
  final bool loading;
  final bool enable;
  final void Function()? onPressed;

  const AuthFilledButton({
    super.key,
    required this.text,
    this.width = double.infinity,
    this.loading = false,
    this.enable = true,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: context.colors.brandBlack,
      ),
      onPressed: (enable && !loading) ? onPressed : null,
      child: (loading)
          ? const CircularProgressIndicator()
          : Text(
              text,
              style: context.textTheme.heading3Bold
                  .tsColor(context.colors.brandWhite),
            ),
    );
  }
}
