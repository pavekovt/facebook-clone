import 'package:async_redux/async_redux.dart';
import 'package:facebook/connectors/HomeScreenConnector.dart';
import 'package:facebook/domain/AppState.dart';
import 'package:facebook/screens/HomeScreen.dart';
import 'package:facebook/screens/LoginScreen.dart';
import 'package:facebook/screens/RegisterScreen.dart';
import 'package:facebook/state/FetchAndSetCurrentUser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget _getScreen() {
    return StoreConnector<AppState, _ViewModel>(
      model: _ViewModel(),
      builder: (context, vm) => StreamBuilder(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return LoginScreen();
          }

          vm.fetchAndSetCurrentUserAction((snapshot.data as FirebaseUser).uid);
          return HomeScreenConnector();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: Store<AppState>(initialState: AppState.initial()),
      child: MaterialApp(
        title: 'Facebook',
        theme: ThemeData(
          // primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            // color: Colors.black,
            // actionsIconTheme: IconThemeData(color: Colors.black) 
          ),
        ),
        home: _getScreen(),
        routes: {
          LoginScreen.id: (context) => LoginScreen(),
          HomeScreen.id: (context) => HomeScreenConnector(),
          RegisterScreen.id: (context) => RegisterScreen()
        },
      ),
    );
  }
}

class _ViewModel extends BaseModel {
  final Function(String) fetchAndSetCurrentUserAction;

  _ViewModel({this.fetchAndSetCurrentUserAction});

  @override
  _ViewModel fromStore() {
    return _ViewModel(
        fetchAndSetCurrentUserAction: (id) =>
            store.dispatch(FetchAndSetCurrentUser(currentUserId: id)));
  }
}
