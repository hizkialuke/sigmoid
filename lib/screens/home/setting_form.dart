import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigmoid/models/firebaseuser.dart';
import 'package:sigmoid/services/database.dart';
import 'package:sigmoid/shared/constants.dart';
import 'package:sigmoid/shared/loading.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({Key? key}) : super(key: key);

  @override
  _SettingFormState createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4', '5'];
  bool showLoading = false;

  // form values
  String _currentName = '';
  String _currentSugars = '';
  int _currentStrength = 0;

  @override
  Widget build(BuildContext context) {
    final FirebaseUser user = Provider.of<FirebaseUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data!;
            return Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  Text('Update your brew setting'),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: userData.name,
                    decoration: textInputDecoration,
                    validator: (val) => val!.isEmpty ? 'Name required' : null,
                    onChanged: (val) {
                      setState(() => _currentName = val);
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value:
                        _currentSugars == '' ? userData.sugars : _currentSugars,
                    onChanged: (val) =>
                        setState(() => _currentSugars = val.toString()),
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        child: Text("$sugar sugar cube(s)"),
                        value: sugar,
                      );
                    }).toList(),
                  ),
                  Slider(
                    value: _currentStrength == 0
                        ? userData.strength!.toDouble()
                        : _currentStrength.toDouble(),
                    activeColor: Colors.brown[_currentStrength == 0
                        ? userData.strength!
                        : _currentStrength],
                    inactiveColor: Colors.brown[_currentStrength == 0
                        ? userData.strength!
                        : _currentStrength],
                    min: 100.0,
                    max: 900.0,
                    divisions: 8,
                    onChanged: (val) {
                      setState(() => _currentStrength = val.round());
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    child: Text('Update'),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.pink[400]),
                        textStyle: MaterialStateProperty.all(
                            TextStyle(color: Colors.white))),
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        await DatabaseService(uid: user.uid).updateUserData(
                            _currentSugars == ''
                                ? userData.sugars!
                                : _currentSugars,
                            _currentName == '' ? userData.name! : _currentName,
                            _currentStrength == 0
                                ? userData.strength!
                                : _currentStrength);
                        Navigator.pop(context);
                      }
                    },
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
