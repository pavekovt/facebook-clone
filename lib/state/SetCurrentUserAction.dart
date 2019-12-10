import 'package:async_redux/async_redux.dart';
import 'package:facebook/domain/AppState.dart';
import 'package:facebook/models/User.dart';
import 'package:flutter/widgets.dart';

class SetCurrentUserAction extends ReduxAction<AppState> {
  final User currentUser;

  SetCurrentUserAction({@required this.currentUser});

  @override
  AppState reduce() {
    return state.copy(currentUser: currentUser);
  }
}

