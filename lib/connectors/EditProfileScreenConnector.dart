import 'package:async_redux/async_redux.dart';
import 'package:facebook/domain/AppState.dart';
import 'package:facebook/models/User.dart';
import 'package:facebook/screens/EditProfileScreen.dart';
import 'package:facebook/state/UpdateAndSetCurrentUser.dart';
import 'package:flutter/material.dart';

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
        ),
      ),
    );
  }
}

class _ViewModel extends BaseModel<AppState> {
  Function(User) setCurrentUserAction;
  User user;

  _ViewModel({this.setCurrentUserAction, this.user}) : super(equals: [user]);

  @override
  BaseModel fromStore() {
    return _ViewModel(
      setCurrentUserAction: (user) =>
          store.dispatch(UpdateAndSetCurrentUser(updatedUser: user)),
      user: store.state.currentUser,
    );
  }
}
