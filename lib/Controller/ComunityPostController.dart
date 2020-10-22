import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aps/Models/ComunityPost.dart';

class ComunityPostController {
  CollectionReference _collection =
      FirebaseFirestore.instance.collection('ComunityPosts');
  String user = FirebaseAuth.instance.currentUser.uid;

  void add(ComunityPost comunityPost) => _collection.add(comunityPost.toJson());

  void update(String documentId, ComunityPost comunityPost) =>
      _collection.doc(documentId).update(comunityPost.toJson());

  void delete(String documentId) => _collection.doc(documentId).delete();

  CollectionReference list() {
    return _collection;
  }

  Stream<QuerySnapshot> listUserPost() {
    return _collection.where('uid', isEqualTo: user).snapshots();
  }
}
