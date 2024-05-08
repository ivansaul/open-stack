import 'package:flutter/material.dart';
import 'package:openstack/src/constants/constants.dart';
import 'package:openstack/src/features/profile/presentation/widgets/avatar_widget.dart';

class AvatarAndCover extends StatelessWidget {
  const AvatarAndCover({
    super.key,
    required this.avatarUrl,
    required this.coverUrl,
  });

  final String? avatarUrl;
  final String? coverUrl;

  @override
  Widget build(BuildContext context) {
    const height = 120.0;
    const borderRadius = 30.0;
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius),
          child: Image.network(
            coverUrl ?? Constants.assetsDefaultProfileCover,
            fit: BoxFit.cover,
            height: height,
          ),
        ),
        AvatarWidget(
          url: avatarUrl,
          height: height,
          borderRadius: borderRadius,
          borderWidth: 4,
        ),
      ],
    );
  }
}
