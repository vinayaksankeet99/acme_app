import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum Status { authenticated, unauthenticated }

class UserRepository with ChangeNotifier {
  final FirebaseAuth _auth;
  Status _status = Status.unauthenticated;
  User? _user;
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
      print(0011);
      final user = await _googleSignIn.signIn();
      print(1);
      final GoogleSignInAuthentication? googleAuth = await user?.authentication;
      print(2);
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print(3);
      final result =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print(4);
      print(result.user?.displayName);
    } catch (e) {
      print('ERRRRR');
      print(e);
      _status = Status.unauthenticated;
      notifyListeners();
    }
  }

  Future signOut() async {}

  Future<void> _onAuthStateChanged(User? firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.authenticated;
    }
    notifyListeners();
  }
}
