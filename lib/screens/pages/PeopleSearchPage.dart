import 'package:async_redux/async_redux.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:facebook/domain/AppState.dart';
import 'package:facebook/models/User.dart';
import 'package:facebook/state/StartSearchingUsers.dart';
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
      ),
    );
  }
}

class _ViewModel extends BaseModel<AppState> {
  List<User> foundUsers;
  Function(String) searchUsers;

  _ViewModel({this.foundUsers, this.searchUsers}) : super(equals: [foundUsers]);

  @override
  BaseModel fromStore() {
    return _ViewModel(
        foundUsers: state.foundUsers,
        searchUsers: (name) => store.dispatch(StartSearchingUsers(name: name)));
  }
}

class PeopleSearchPage extends StatefulWidget {
  final List<User> foundUsers;
  final Function(String) searchUsers;

  const PeopleSearchPage(
      {Key key, this.foundUsers = const [], this.searchUsers})
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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              CupertinoTextField(
                onChanged: (input) => setState(() => _searchName = input),
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
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: user.profileImageUrl.isNotEmpty
                                ? CachedNetworkImageProvider(user.profileImageUrl)
                                : AssetImage("assets/images/empty-profile.png"),
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
                                    "4 mutual friend",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                FlatButton(
                                  color: Colors.blue.shade700,
                                  onPressed: () {},
                                  child: Text(
                                    "Add Friend",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
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
