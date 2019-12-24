import 'package:async_redux/async_redux.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:facebook/domain/AppState.dart';
import 'package:facebook/models/User.dart';
import 'package:facebook/services/UserService.dart';
import 'package:facebook/state/SetSearchedUsers.dart';
import 'package:flutter/widgets.dart';

class StartSearchingUsers extends ReduxAction<AppState> {
  static Stream<QuerySnapshot> stream;

  final String name;

  StartSearchingUsers({@required this.name});

  @override
  Future<AppState> reduce() async {
    stream = UserService.streamForUsers(name).asStream();
    stream.listen((snapshot) async {
      List<User> users = await Future.wait(snapshot.documents.map((userSnap) async { 
        var userFriends = await UserService.userFriends(userSnap.documentID);
        var user = User.fromDoc(userSnap);
        user.friends = userFriends.map((f) => f.documentID).toList();
        return user;
      }).toList());
      dispatch(SetSearchedUsers(users: users));
    });

    return null;
  }
}
