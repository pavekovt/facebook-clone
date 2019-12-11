import 'package:async_redux/async_redux.dart';
import 'package:facebook/domain/AppState.dart';
import 'package:facebook/models/User.dart';
import 'package:facebook/screens/pages/FeedPage.dart';
import 'package:facebook/screens/pages/NotificationPage.dart';
import 'package:facebook/screens/pages/PeopleSearchPage.dart';
import 'package:facebook/screens/pages/ProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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


class HomeScreen extends StatefulWidget {
  static String id = "HomeScreen";

  final User currentUser;

  const HomeScreen({Key key, this.currentUser}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _currentPage = 0;
    _pageController = PageController();
  }

  _changePage() {
    _pageController.animateToPage(_currentPage,
        duration: Duration(milliseconds: 100), curve: Curves.easeInExpo);
  }

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
          currentIndex: _currentPage,
          onTap: (index) => setState(() {
            _currentPage = index;
            _changePage();
          }),
          backgroundColor: Colors.white,
          border: Border(),
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home)),
            BottomNavigationBarItem(icon: Icon(Icons.people)),
            BottomNavigationBarItem(icon: Icon(Icons.portrait)),
            BottomNavigationBarItem(icon: Icon(Icons.notifications)),
          ],
        ),
        body: PageView(
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            FeedPage(),
            PeopleSearchPageConnector(),
            ProfilePage(
              user: widget.currentUser,
            ),
            NotificationPage(),
          ],
        ),
      ),
    );
  }
}
