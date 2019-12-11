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
  AppState reduce() {
    stream = UserService.streamForUsers(name).asStream();
    stream.listen((snapshot) {
      List<User> users = snapshot.documents.map((userSnap) { 
        return User.fromDoc(userSnap);
      }).toList();      
      dispatch(SetSearchedUsers(users: users));
    });

    return null;
  }
}
