import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aps/Models/Finance.dart';

class FinanceController {
  CollectionReference _collection =
      FirebaseFirestore.instance.collection('FinancePost');
  String user = FirebaseAuth.instance.currentUser.uid;

  void add(Finance finance) =>
      _collection.doc(user).collection('Finance').add(finance.toJson());

  void update(String documentId, Finance finance) => _collection
      .doc(user)
      .collection('Finance')
      .doc(documentId)
      .update(finance.toJson());

  void delete(String documentId) =>
      _collection.doc(user).collection('Finance').doc(documentId).delete();

  CollectionReference list() {
    return _collection.doc(user).collection('Finance');
  }
}
