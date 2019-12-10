import 'package:facebook/services/AuthService.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static String id = "RegisterScreen";

  RegisterScreen({Key key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = new GlobalKey<FormState>();
  }

  String _email;
  String _password;
  String _name;

  _submit() {
    if (_formKey.currentState.validate()) {
      AuthService.signUpUser(context, _name, _email, _password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Facebook',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 40.0),
                  child: Column(
                    children: [
                      TextFormField(
                        onChanged: (data) => setState(() => _name = data),
                        validator: (input) => input.trim().isEmpty
                            ? 'Please enter correct name'
                            : null,
                        decoration: InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          onChanged: (data) => setState(() => _email = data),
                          validator: (input) => !input.contains('@')
                              ? 'Please enter correct email'
                              : null,
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          onChanged: (data) => setState(() => _password = data),
                          obscureText: true,
                          validator: (input) => input.length < 6
                              ? 'Password should contain at least 6 characters'
                              : null,
                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(),
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
                            child: Text('Sign Up'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
