import 'package:firebase_auth/firebase_auth.dart';
import 'package:sigmoid/models/firebaseuser.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create FirebaseUser object based on User
  FirebaseUser? _userfromFirebase(User user) {
    return user != null ? FirebaseUser(uid: user.uid) : null;
  }

  // change auth stream
  Stream<FirebaseUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userfromFirebase(user!));
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userfromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email

  // register with email
  Future registerWithEmail(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userfromFirebase(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
