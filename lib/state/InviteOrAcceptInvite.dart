import 'package:async_redux/async_redux.dart';
import 'package:facebook/domain/AppState.dart';
import 'package:facebook/services/UserService.dart';
import 'package:flutter/widgets.dart';

class InviteOrAcceptInvite extends ReduxAction<AppState> {
  final String userId;

  InviteOrAcceptInvite({@required this.userId});

  @override
  Future<AppState> reduce() async {
    await UserService.inviteOrAcceptFriend(state.currentUser.id, userId);
    return null;
  }
}
