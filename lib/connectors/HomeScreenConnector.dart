import 'package:async_redux/async_redux.dart';
import 'package:facebook/domain/AppState.dart';
import 'package:facebook/models/User.dart';
import 'package:facebook/screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';

class HomeScreenConnector extends StatelessWidget {
  const HomeScreenConnector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      model: _ViewModel(),
      builder: (context, vm) => HomeScreen(
        currentUser: vm.currentUser,
      ),
    );
  }
}

class _ViewModel extends BaseModel<AppState> {
  User currentUser;

  _ViewModel({this.currentUser}): super(equals: [currentUser]);

  @override
  BaseModel fromStore() {
    return _ViewModel(currentUser: store.state.currentUser);
  }
}
