import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aps/Models/User.dart';

class UserController {
  CollectionReference _collection =
      FirebaseFirestore.instance.collection('users');
  String user = FirebaseAuth.instance.currentUser.uid;

  void add(Users person) => _collection.doc(user).update(person.toJson());

  void update(String documentId, Users person) =>
      _collection.doc(documentId).update(person.toJson());

  void delete(String documentId) => _collection.doc(documentId).delete();
  DocumentReference list() {
    return _collection.doc(user);
  }
}
