import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fizmat_app_flutter/fizmat_utils/user.dart';

class DatabaseManager {
  CollectionReference? ref;
  FirebaseFirestore? db;

  DatabaseManager() {
    db = FirebaseFirestore.instance;
    ref = db?.collection("users").withConverter<UserFiz>(
        fromFirestore: (snapshot, _) => UserFiz.fromJson(snapshot.data()!),
        toFirestore: (model, _) => model.toJson());
  }

  void addUser(UserFiz user) {
    ref?.doc(user.getEmail()).set(user);
  }
}
