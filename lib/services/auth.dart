import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;
  //login
  Future<AuthResult> login(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<AuthResult> register(String email, String password) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> logOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  Stream<FirebaseUser> authStream() {
    return _auth.onAuthStateChanged;
  }
}
