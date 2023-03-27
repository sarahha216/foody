import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foody/data/models/user_model.dart';

class AuthService{
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future register(String email, String password) async{
    try{
      User user = (await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password)).user!;

      if(user!=null){
        Map<String, dynamic> map ={
          'email': email,
          'password': password,
        };
        FirebaseFirestore.instance.collection('users').doc(user.uid).set(map);
        return true;
      }

    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  Future login(String email, String password) async{
    try{
      User user = (await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)).user!;

      if(user!=null){
        return true;
      }
    }
    on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  Future<Map<String, dynamic>?> getUserData() async{
    Map<String, dynamic>? userData;
    await FirebaseFirestore.instance.collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) async{
      userData = value.data();
    });
    return userData;
  }


}