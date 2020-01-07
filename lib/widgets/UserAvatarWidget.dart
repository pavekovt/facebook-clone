import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/models/User.dart';
import 'package:flutter/material.dart';

class UserAvatarWidget extends StatelessWidget {
  final User user;
  final double radius;

  const UserAvatarWidget({Key key, this.user, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        radius: radius,
        backgroundImage: user.profileImageUrl.isNotEmpty
            ? CachedNetworkImageProvider(user.profileImageUrl)
            : AssetImage("assets/images/empty-profile.png"),
      ),
    );
  }
}
