import 'package:async_redux/async_redux.dart';
import 'package:facebook/domain/AppState.dart';
import 'package:facebook/models/User.dart';
import 'package:flutter/widgets.dart';

class SetSearchedUsers extends ReduxAction<AppState> {
  final List<User> users;

  SetSearchedUsers({@required this.users});

  @override
  AppState reduce() {
    return store.state.copy(foundUsers: users);
  }
}
