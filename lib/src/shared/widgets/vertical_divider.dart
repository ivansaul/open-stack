import 'package:flutter/material.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';

class DividerVertical extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  const DividerVertical({
    super.key,
    this.width = 3,
    this.height = 20,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? context.colors.greyGrey200,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
