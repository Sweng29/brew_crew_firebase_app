import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Scaffold(
        appBar: AppBar(
          elevation: 5.0,
          title: Text('Brew Crew'),
          backgroundColor: Colors.teal[500],
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () async {
                await _authService.signOut();
              },
              icon: Icon(
                Icons.people_outline,
                color: Colors.white,
              ),
              label: Text(
                'Logout',
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
      ),
    );
  }
}
