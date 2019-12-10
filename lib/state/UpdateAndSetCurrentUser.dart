import 'package:async_redux/async_redux.dart';
import 'package:facebook/domain/AppState.dart';
import 'package:facebook/models/User.dart';
import 'package:facebook/services/UserService.dart';
import 'package:facebook/state/SetCurrentUserAction.dart';
import 'package:flutter/widgets.dart';

class UpdateAndSetCurrentUser extends ReduxAction<AppState> {
  final User updatedUser;

  UpdateAndSetCurrentUser({@required this.updatedUser});

  @override
  Future<AppState> reduce() async {
    await UserService.updateUser(updatedUser);
    store.dispatch(SetCurrentUserAction(currentUser: updatedUser));
    return null;
  }
}
