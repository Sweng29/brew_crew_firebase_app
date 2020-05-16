import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'brew_list.dart';

class Home extends StatelessWidget {
  final _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
              child: SettingsForm(),
            );
          });
    }

    return Container(
      child: StreamProvider<List<Brew>>.value(
        value: DatabaseService().brews,
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
              ),
              FlatButton.icon(
                onPressed: () => _showSettingsPanel(),
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                label: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: Colors.teal[300],
          body: Container(
            child: BrewList(),
//            decoration: BoxDecoration(
//              image: DecorationImage(
//              image: AssetImage('assets/coffee_bg.png'),fit: BoxFit.cover,
//            ),
//            ),
          ),
        ),
      ),
    );
  }
}
