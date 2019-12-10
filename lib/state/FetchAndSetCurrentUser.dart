import 'package:async_redux/async_redux.dart';
import 'package:facebook/domain/AppState.dart';
import 'package:facebook/models/User.dart';
import 'package:facebook/services/UserService.dart';
import 'package:facebook/state/SetCurrentUserAction.dart';
import 'package:flutter/widgets.dart';

class FetchAndSetCurrentUser extends ReduxAction<AppState> {
  final String currentUserId;

  FetchAndSetCurrentUser({@required this.currentUserId});

  @override
  Future<AppState> reduce() async {
    User user = await UserService.getUserById(currentUserId);
    store.dispatch(SetCurrentUserAction(currentUser: user));
    return null;
  }
}
