import 'package:async_redux/async_redux.dart';
import 'package:facebook/domain/AppState.dart';
import 'package:facebook/models/User.dart';
import 'package:facebook/state/InviteOrAcceptInvite.dart';
import 'package:facebook/state/RemoveFriend.dart';
import 'package:facebook/widgets/UserAvatarWidget.dart';
import 'package:flutter/material.dart';

class UserCardWidgetConnector extends StatelessWidget {
  final User user;

  const UserCardWidgetConnector({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      model: _ViewModel(),
      builder: (context, vm) => UserCardWidget(
        currentUser: vm.currentUser,
        inviteUser: vm.inviteUser,
        removeFriend: vm.removeFriend,
        user: user,
      ),
    );
  }
}

class _ViewModel extends BaseModel<AppState> {
  Function(String) inviteUser;
  Function(String) removeFriend;
  User currentUser;

  _ViewModel({this.currentUser, this.inviteUser, this.removeFriend})
      : super(equals: [currentUser]);

  @override
  BaseModel fromStore() {
    return _ViewModel(
        currentUser: state.currentUser,
        inviteUser: (userId) =>
            store.dispatch(InviteOrAcceptInvite(userId: userId)),
        removeFriend: (friendId) =>
            store.dispatch(RemoveFriend(friendId: friendId)));
  }
}

class UserCardWidget extends StatelessWidget {
  final User user;
  final User currentUser;
  final Function(String) inviteUser;
  final Function(String) removeFriend;

  const UserCardWidget(
      {Key key,
      this.user,
      this.currentUser,
      this.inviteUser,
      this.removeFriend})
      : super(key: key);

  getMutualFriendsAmount(User user) {
    return currentUser.friends.where((f) => user.friends.contains(f)).length;
  }

  inviteOrRemove(User user) {
    if (currentUser.friends.contains(user.id)) {
      return FlatButton(
        color: Colors.grey.shade300,
        onPressed: () => removeFriend(user.id),
        child: Text(
          "Remove Friend",
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      );
    } else {
      return FlatButton(
        color: Colors.blue.shade700,
        onPressed: () => inviteUser(user.id),
        child: Text(
          "Add Friend",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          UserAvatarWidget(
            radius: 50,
            user: user,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      user.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    user.city.isNotEmpty
                        ? Text(
                            " from ${user.city}",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          )
                        : SizedBox.shrink(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    "${getMutualFriendsAmount(user)} mutual friend",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                inviteOrRemove(user)
              ],
            ),
          )
        ],
      ),
    );
  }
}
