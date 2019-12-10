import 'package:facebook/models/User.dart';
import 'package:facebook/services/AuthService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static String id = "HomeScreen";

  final User currentUser;

  const HomeScreen({Key key, this.currentUser}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Facebook',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: 0,
          backgroundColor: Colors.white,
          border: Border(),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.portrait)
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications)
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Hello ${widget.currentUser?.name ?? "temp"}!'),
                FlatButton(
                  onPressed: () => AuthService.logout(),
                  color: Colors.blue,
                  child: Text(
                    "Log Out",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
