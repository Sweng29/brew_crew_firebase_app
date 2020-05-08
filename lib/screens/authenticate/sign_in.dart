import 'package:brew_crew/screens/shared/constants.dart';
import 'package:brew_crew/screens/shared/loading.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({this.toggleView});

  @override
  _SignInState createState() => new _SignInState();
}

class _SignInState extends State<SignIn> {
  final _authService = AuthService();
  String email = '';
  String password = '';
  String error = '';
  bool loading = false;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              elevation: 3.0,
              title: Text('Sign in - Brew Crew'),
              backgroundColor: Colors.teal[500],
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(
                    Icons.people,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                )
              ],
            ),
            backgroundColor: Colors.teal[300],
            body: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 50,
              ),
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    SizedBox(height: 20),
                    TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Enter a valid email.' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      decoration: textDecoration.copyWith(
                          hintText: 'Enter email address'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: textDecoration.copyWith(hintText: 'Password'),
                      validator: (val) => val.length < 6
                          ? 'Passowrd length must be greater then 6 characters.'
                          : null,
                      onChanged: (val) {
                        setState(() => password = val);
                      },
                      obscureText: true,
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 20),
                    RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _authService
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              loading = false;
                              error = 'Please enter a valid email.';
                            });
                          }
                        }
                      },
                      color: Colors.white,
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.teal),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      error,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
