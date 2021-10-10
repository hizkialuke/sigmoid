import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sigmoid/models/firebaseuser.dart';
import 'package:sigmoid/screens/authenticate/authenticate.dart';
import 'package:sigmoid/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseUser? user = Provider.of<FirebaseUser?>(context);

    // return either home / authentication widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
