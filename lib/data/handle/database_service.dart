import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:foody/data/models/food.dart';

class DatabaseService {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference = firebaseDatabase.ref('users');

  Future<int> loadCounter() async {
    DataSnapshot snap = await databaseReference.child(uid).child('cart').get();
    int quantity = 0;
    if (snap.value != null) {
      Map data = snap.value as Map;

      return quantity = data.entries
          .map((e) => e.value['quantity'])
          .reduce((a, b) => (a + b));
    } else {
      return quantity = 0;
    }
  }

  Future<void> addFavorite({required Food food}) async {
    try {
      await databaseReference
          .child(uid)
          .child('favorite')
          .child(food.foodKey)
          .set(food.toMap());
    } on FirebaseException {
      rethrow;
    }
  }

  Future<void> removeFavorite({required String foodKey}) async {
    try {
      await databaseReference.child(uid).child('favorite')
          .child(foodKey)
          .remove();
    } on FirebaseException {
      rethrow;
    }
  }
}
