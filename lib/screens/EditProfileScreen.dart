import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/domain/AppState.dart';
import 'package:facebook/models/User.dart';
import 'package:facebook/state/UpdateAndSetCurrentUser.dart';
import 'package:facebook/state/UpdateUserProfileImageAction.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreenConnector extends StatelessWidget {
  const EditProfileScreenConnector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StoreConnector<AppState, _ViewModel>(
        model: _ViewModel(),
        builder: (context, vm) => EditProfileScreen(
          user: vm.user,
          updateUserAction: vm.setCurrentUserAction,
          updateProfileImage: vm.updateProfileImage,
        ),
      ),
    );
  }
}

class _ViewModel extends BaseModel<AppState> {
  Function(User) setCurrentUserAction;
  Function(File) updateProfileImage;
  User user;

  _ViewModel({this.setCurrentUserAction, this.updateProfileImage, this.user})
      : super(equals: [user]);

  @override
  BaseModel fromStore() {
    return _ViewModel(
      setCurrentUserAction: (user) =>
          store.dispatch(UpdateAndSetCurrentUser(updatedUser: user)),
      updateProfileImage: (img) =>
          store.dispatch(UpdateUserProfileImageAction(profileImg: img)),
      user: store.state.currentUser,
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  final User user;
  final Function(User) updateUserAction;
  final Function(File) updateProfileImage;
  final bool isLoading;

  const EditProfileScreen(
      {Key key,
      this.user,
      this.updateUserAction,
      this.isLoading,
      this.updateProfileImage})
      : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String _city;
  String _name;
  File _image;

  @override
  void initState() {
    super.initState();
    _city = widget.user.city;
    _name = widget.user.name;
  }

  _updateProfile() async {
    if (_formKey.currentState.validate()) {
      var updatedUser = widget.user
        ..city = _city
        ..name = _name;

      widget.updateUserAction(updatedUser);
      if (_image != null) widget.updateProfileImage(_image);
    }
  }

  _chageImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() => _image = image);
  }

  Widget _buildProfilePicture() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Container(
          width: 160,
          child: Stack(
            children: [
              _image == null
                  ? CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 80,
                      backgroundImage: widget.user.profileImageUrl.isEmpty
                          ? AssetImage("assets/images/empty-profile.png")
                          : CachedNetworkImageProvider(
                              widget.user.profileImageUrl),
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 80,
                      backgroundImage: FileImage(_image),
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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Center(
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
        ),
      ),
    );
  }
}
