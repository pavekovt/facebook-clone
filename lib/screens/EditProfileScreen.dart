import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/models/User.dart';
import 'package:facebook/services/StorageService.dart';
import 'package:facebook/services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  final User user;
  final Function(User) updateUserAction;
  final bool isLoading;

  const EditProfileScreen({Key key, this.user, this.updateUserAction, this.isLoading}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String _city;
  String _name;

  void _updateProfile() async {
    if (_formKey.currentState.validate()) {
      widget.user.name = _name;
      widget.user.city = _city;

      widget.updateUserAction(widget.user);
    }
  }
  _chageImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    String profileImageUrl = await StorageService.uploadUserProfileImage(
        widget.user.profileImageUrl, image);
    widget.user.profileImageUrl = profileImageUrl;
    UserService.updateUser(widget.user);
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
              GestureDetector(
                onTap: _chageImage,
                child: Container(
                  height: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black,
                        Color.fromRGBO(0, 0, 0, 0),
                        Color.fromRGBO(0, 0, 0, 0)
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 160,
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.photo_camera,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 16),
            Text(
              "Details",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            _buildProfilePicture(),
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      initialValue: widget.user.name,
                      onChanged: (input) => setState(() => _name = input),
                      validator: (input) => input.trim().length < 4
                          ? "Please enter valid name"
                          : null,
                      decoration: InputDecoration(
                        labelText: "Name",
                      ),
                    ),
                    SizedBox(height: 2),
                    TextFormField(
                      initialValue: widget.user.city,
                      onChanged: (input) => setState(() => _city = input),
                      decoration: InputDecoration(
                        labelText: "City",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        width: 200,
                        child: FlatButton(
                          color: Colors.blue,
                          onPressed: _updateProfile,
                          child: Text(
                            "Save Profile",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
