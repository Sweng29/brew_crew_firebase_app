import 'package:brew_crew/screens/shades/constants.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {
  final _authService = AuthService();
  String email = '';
  String password = '';
  final _formKey = GlobalKey<FormState>();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        title: Text('Register- Brew Crew'),
        backgroundColor: Colors.teal[500],
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              widget.toggleView();
            },
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              'Sign in',
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
                decoration:
                    textDecoration.copyWith(hintText: 'Enter email address'),
                validator: (val) => val.isEmpty ? 'Enter a valid email.' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                  fontSize: 16,
                ),
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
                    dynamic result = await _authService
                        .registerWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = 'Please enter a valid email.';
                      });
                    }
                  }
                },
                color: Colors.white,
                child: Text(
                  'Register',
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
