import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => new _SignInState();
}

class _SignInState extends State<SignIn> {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Sign in - Brew Crew'),
        backgroundColor: Colors.teal[500],
      ),
      backgroundColor: Colors.teal[200],
      body: Container(
        padding: EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: RaisedButton(
          onPressed: () async {
            dynamic user = await _authService.signInAnon();
            if (user == null) {
              print('Could not sign in, try again.');
            } else {
              print('Sign in successfull.');
              print(user);
            }
          },
          child: Text('Sign in anon'),
          elevation: 5.0,
        ),
      ),
    );
  }
}
