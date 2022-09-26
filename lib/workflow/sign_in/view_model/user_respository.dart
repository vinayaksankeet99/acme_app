import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum Status { authenticated, unauthenticated }

class UserRepository with ChangeNotifier {
  final FirebaseAuth _auth;
  Status _status = Status.unauthenticated;

  UserRepository.instance() : _auth = FirebaseAuth.instance {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/user.gender.read',
    ],
  );
  Status get status => _status;

  Future<void> signInWithGoogle() async {
    try {
      final user = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await user?.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      _status = Status.unauthenticated;
      notifyListeners();
    }
  }

  Future signOut() async {}

// detects when there is a change in user authentication (login / logout)
  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.unauthenticated;
    } else {
      _status = Status.authenticated;
    }
    notifyListeners();
  }
}
