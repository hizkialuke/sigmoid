import 'package:flutter/material.dart';
import 'package:sigmoid/services/auth.dart';

class SignIn extends StatefulWidget {
  // const SignIn({Key? key}) : super(key: key);

  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in to Sigmoid'),
        actions: <Widget>[
          TextButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Sign Up'))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Form(
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  onChanged: (val) {
                    setState(() => email = val.trim());
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => password = val.trim());
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Sign In'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.pink[400]),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(color: Colors.white))),
                  onPressed: () async {
                    print(email);
                    print(password);
                  },
                )
              ],
            ),
          )),
    );
  }
}
