import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future register(String email, String password, String name) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        Map<String, dynamic> map = {
          'userID': user.uid,
          'email': email,
          'password': password,
          'name': name,
          'address': '',
          'mobile': '',
        };
        FirebaseDatabase.instance.ref('users').child(user.uid).set(map);
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future login(String email, String password) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;

      if (user != null) {
        return true;
      }
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<bool> checkCurrentPassword(String password) async {
    var firebaseUser = await firebaseAuth.currentUser!;

    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser.email.toString(), password: password);
    try {
      var authResult =
          await firebaseUser.reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
