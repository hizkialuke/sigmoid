import 'package:flutter/material.dart';
import 'package:sigmoid/services/auth.dart';

class Register extends StatefulWidget {
  // const Register({Key? key}) : super(key: key);

  final Function toggleView;
  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String errorMsg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign up to Sigmoid'),
        actions: <Widget>[
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Sign In'))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() => email = val.trim());
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  validator: (val) => val!.length < 6
                      ? 'Password must be longer than 6 chars'
                      : null,
                  onChanged: (val) {
                    setState(() => password = val.trim());
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Sign Up'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.pink[400]),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(color: Colors.white))),
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      // print(email);
                      // print(password);
                      dynamic result =
                          await _authService.registerWithEmail(email, password);
                      if (result == null) {
                        setState(() => errorMsg = 'please input a valid email');
                      } else {}
                    }
                  },
                ),
                SizedBox(height: 20),
                Text(
                  errorMsg,
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
          )),
    );
  }
}