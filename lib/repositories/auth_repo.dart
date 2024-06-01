import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth;

  AuthRepo(this._firebaseAuth);

  Future<void> logIn(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> register(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
