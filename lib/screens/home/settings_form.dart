import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/shared/constants.dart';
import 'package:brew_crew/screens/shared/loading.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => new _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugar;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Text(
                    'Update your brew Settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textDecoration.copyWith(hintText: 'Name'),
                    validator: (val) =>
                        val.length < 6 ? 'Please enter a name.' : null,
                    onChanged: (val) {
                      setState(() => _currentName = val);
                    },
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20.0),
                  //dropdown
                  DropdownButtonFormField(
                      decoration: textDecoration,
                      value: _currentSugar ?? userData.sugars,
                      items: sugars.map((sugar) {
                        return DropdownMenuItem(
                          child: Text('$sugar sugars'),
                          value: sugar,
                        );
                      }).toList(),
                      onChanged: (val) {
                        setState(() => _currentSugar = val);
                      }),
                  Slider(
                    value: (_currentStrength ?? userData.strength).toDouble(),
                    activeColor:
                        Colors.teal[_currentStrength ?? userData.strength],
                    inactiveColor:
                        Colors.teal[_currentStrength ?? userData.strength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) {
                      setState(
                        () {
                          _currentStrength = val.round();
                        },
                      );
                    },
                  ),
                  //slider
                  RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugar ?? userData.sugars,
                            _currentName ?? userData.name,
                            _currentStrength ?? userData.strength);
                      }
                      Navigator.pop(context);
                    },
                    color: Colors.white,
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.teal),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
