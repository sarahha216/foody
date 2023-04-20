import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class MyFunction {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  FirebaseDatabase firebaseDatabase = FirebaseDatabase.instance;
  late DatabaseReference databaseReference = firebaseDatabase.ref('users');

  //int quantity = 0;

  Future<int> loadData() async {
    DataSnapshot snap = await databaseReference.child(uid).child('cart').get();
    int quantity = 0;
    if (snap.value != null) {
      Map data = snap.value as Map;

      return quantity = data.entries
          .map((e) => e.value['quantity'])
          .reduce((a, b) => (a + b));

      print(quantity);
    } else {
      return quantity = 0;
    }
  }
}
