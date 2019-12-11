import 'package:facebook/models/User.dart';
import 'package:flutter/cupertino.dart';

@immutable
class AppState {
  final User currentUser;
  final List<User> foundUsers; 

  AppState({@required this.foundUsers, @required this.currentUser});

  factory AppState.initial() => AppState(currentUser: null, foundUsers: []);

  AppState copy({User currentUser, List<User> foundUsers}) {
    var a = AppState(
      foundUsers: foundUsers ?? this.foundUsers,
      currentUser: currentUser ?? this.currentUser 
    );
    return a;
  }
}