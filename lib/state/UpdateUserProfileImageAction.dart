import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:facebook/domain/AppState.dart';
import 'package:facebook/services/StorageService.dart';
import 'package:facebook/state/UpdateAndSetCurrentUser.dart';
import 'package:flutter/widgets.dart';

class UpdateUserProfileImageAction extends ReduxAction<AppState> {
  final File profileImg;

  UpdateUserProfileImageAction({@required this.profileImg});

  @override
  Future<AppState> reduce() async {
    var profileImageUrl = await StorageService.uploadUserProfileImage(store.state.currentUser.id, profileImg);
    var updatedUser = store.state.currentUser;
    updatedUser.profileImageUrl = profileImageUrl;

    dispatch(UpdateAndSetCurrentUser(updatedUser: updatedUser));
    return null;
  }
}
