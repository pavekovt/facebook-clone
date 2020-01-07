import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/models/User.dart';
import 'package:facebook/screens/EditProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final bool editableProfile;
  final User user;

  const ProfilePage({Key key, this.user, this.editableProfile = false})
      : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[_buildProfilePicture(), _buildProfileData()],
        ),
      ),
    );
  }

  Widget _editProfileButton() {
    if (!widget.editableProfile) return SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 25,
        child: FlatButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditProfileScreenConnector(),
              )),
          color: Colors.blue,
          child: Text(
            "Edit Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileData() {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            widget.user.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "Lives in ${widget.user.city.isNotEmpty ? widget.user.city : "Somewhere"}",
            style: TextStyle(color: Colors.grey),
          ),
          _editProfileButton()
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          width: 160,
          child: Stack(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 80,
                backgroundImage: widget.user.profileImageUrl.isEmpty
                    ? AssetImage("assets/images/empty-profile.png")
                    : CachedNetworkImageProvider(widget.user.profileImageUrl),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
