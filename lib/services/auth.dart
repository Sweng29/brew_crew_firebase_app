import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// Sign in with anonaymous

  Future signInAnon() async {
    try {
      AuthResult authResult = await _auth.signInAnonymously();
      FirebaseUser firebaseUser = authResult.user;
      return firebaseUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

// sign in with email and password

// register with email and password

// sign out

}
