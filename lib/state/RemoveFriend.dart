import 'package:async_redux/async_redux.dart';
import 'package:facebook/domain/AppState.dart';
import 'package:facebook/services/UserService.dart';
import 'package:flutter/widgets.dart';

class RemoveFriend extends ReduxAction<AppState> {
  final String friendId;

  RemoveFriend({@required this.friendId});

  @override
  Future<AppState> reduce() async {
    await UserService.removeFriend(state.currentUser.id, friendId);
    state.currentUser.friends.remove(friendId);
    return state;
  }
}
