import 'package:async_redux/async_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/domain/AppState.dart';
import 'package:facebook/models/User.dart';
import 'package:facebook/state/InviteOrAcceptInvite.dart';
import 'package:facebook/state/RemoveFriend.dart';
import 'package:facebook/state/StartSearchingUsers.dart';
import 'package:facebook/widgets/UserAvatarWidget.dart';
import 'package:facebook/widgets/UserCardWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PeopleSearchPageConnector extends StatelessWidget {
  const PeopleSearchPageConnector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      model: _ViewModel(),
      builder: (context, vm) => PeopleSearchPage(
        foundUsers: vm.foundUsers,
        searchUsers: vm.searchUsers,
        currentUser: vm.currentUser,
        inviteUser: vm.inviteUser,
        removeFriend: vm.removeFriend,
      ),
    );
  }
}

class _ViewModel extends BaseModel<AppState> {
  List<User> foundUsers;
  Function(String) searchUsers;
  Function(String) inviteUser;
  Function(String) removeFriend;
  User currentUser;

  _ViewModel(
      {this.foundUsers,
      this.searchUsers,
      this.currentUser,
      this.inviteUser,
      this.removeFriend})
      : super(equals: [foundUsers, currentUser]);

  @override
  BaseModel fromStore() {
    return _ViewModel(
        foundUsers: state.foundUsers,
        searchUsers: (name) => store.dispatch(StartSearchingUsers(name: name)),
        currentUser: state.currentUser,
        inviteUser: (userId) =>
            store.dispatch(InviteOrAcceptInvite(userId: userId)),
        removeFriend: (friendId) =>
            store.dispatch(RemoveFriend(friendId: friendId)));
  }
}

class PeopleSearchPage extends StatefulWidget {
  final List<User> foundUsers;
  final Function(String) searchUsers;
  final Function(String) inviteUser;
  final Function(String) removeFriend;
  final User currentUser;

  const PeopleSearchPage(
      {Key key,
      this.foundUsers = const [],
      this.searchUsers,
      this.currentUser,
      this.inviteUser,
      this.removeFriend})
      : super(key: key);

  @override
  _PeopleSearchPageState createState() => _PeopleSearchPageState();
}

class _PeopleSearchPageState extends State<PeopleSearchPage> {
  String _searchName;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 200,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoTextField(
                  onChanged: (input) => setState(() => _searchName = input),
                ),
              ),
              FlatButton(
                child: Text("Search"),
                onPressed: () => widget.searchUsers(_searchName),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.foundUsers.length,
                  itemBuilder: (context, index) {
                    var user = widget.foundUsers[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: UserCardWidgetConnector(
                        user: user,
                      )
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
