import 'package:facebook/services/AuthService.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: () => AuthService.logout(),
          child: Text("LOGOUT"),
        ),
      ),
    );
  }
}
