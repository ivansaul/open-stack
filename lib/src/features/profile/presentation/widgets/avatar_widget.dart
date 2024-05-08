import 'package:flutter/material.dart';
import 'package:openstack/src/constants/constants.dart';
import 'package:openstack/src/shared/extensions/context_extensions.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({
    super.key,
    required this.url,
    this.height = 120,
    this.borderRadius = 20,
    this.borderWidth = 0,
  });

  final String? url;
  final double height;
  final double borderRadius;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: NetworkImage(url ?? Constants.assetsDefaultAvatar),
          fit: BoxFit.cover,
        ),
        border: borderWidth == 0
            ? null
            : Border.all(
                color: context.colors.brandBlack,
                width: borderWidth,
                strokeAlign: BorderSide.strokeAlignInside,
              ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}
