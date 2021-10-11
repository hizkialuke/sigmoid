import 'package:flutter/material.dart';
import 'package:sigmoid/services/auth.dart';
import 'package:sigmoid/shared/constants.dart';
import 'package:sigmoid/shared/loading.dart';

class SignIn extends StatefulWidget {
  // const SignIn({Key? key}) : super(key: key);

  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();
  bool showLoading = false;

  // text field state
  String email = '';
  String password = '';
  String errorMsg = '';

  @override
  Widget build(BuildContext context) {
    return showLoading
        ? Loading()
        : Scaffold(
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
                  icon: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  label: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                )
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
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val!.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val.trim());
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (val) => val!.length < 6
                            ? 'Password must be longer than 6 chars'
                            : null,
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
                          if (_formkey.currentState!.validate()) {
                            setState(() => showLoading = true);
                            dynamic result = await _authService.signInWithEmail(
                                email, password);
                            if (result == null) {
                              setState(() {
                                errorMsg = 'Credentials not found';
                                showLoading = false;
                              });
                            }
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
