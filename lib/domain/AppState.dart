import 'package:facebook/models/User.dart';
import 'package:flutter/cupertino.dart';

@immutable
class AppState {
  final User currentUser;
  
  AppState({@required this.currentUser});

  factory AppState.initial() => AppState(currentUser: null);

  AppState copy({User currentUser}) {
    var a = AppState(
      currentUser: currentUser ?? this.currentUser 
    );
    return a;
  }
}