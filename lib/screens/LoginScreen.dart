import 'package:facebook/screens/RegisterScreen.dart';
import 'package:facebook/services/AuthService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static String id = "LoginScreen";

  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = new GlobalKey<FormState>();
  }

  String _email;
  String _password;

  _submit() {
    if (_formKey.currentState.validate()) {
      AuthService.login(_email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.blue,
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Facebook',
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 40.0, 16.0, 0),
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (data) => setState(() => _email = data),
                        validator: (input) => !input.contains('@')
                            ? 'Please enter correct email'
                            : null,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.zero,
                              bottomRight: Radius.zero,
                              topLeft: Radius.circular(3),
                              topRight: Radius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      SizedBox.fromSize(size: Size.fromHeight(10)),
                      TextFormField(
                        onChanged: (data) => setState(() => _password = data),
                        obscureText: true,
                        validator: (input) => input.length < 6
                            ? 'Password should contain at least 6 characters'
                            : null,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.zero,
                              topRight: Radius.zero,
                              bottomLeft: Radius.circular(3),
                              bottomRight: Radius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          width: 400,
                          child: FlatButton(
                            onPressed: () => _submit(),
                            textColor: Colors.white,
                            color: Colors.blue,
                            child: Text('Log In'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              FlatButton(
                onPressed: () =>
                    Navigator.pushNamed(context, RegisterScreen.id),
                child: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
