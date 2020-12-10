import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aps/Models/Comment.dart';

class CommentController {
  CollectionReference _collection =
      FirebaseFirestore.instance.collection('Comments');
  String user = FirebaseAuth.instance.currentUser.uid;

  void add(Comment comment) => _collection.add(comment.toJson());

  void update(String documentId, Comment comment) =>
      _collection.doc(documentId).update(comment.toJson());

  void delete(String documentId) => _collection.doc(documentId).delete();

  Stream<QuerySnapshot> list(String documentId) {
    return _collection.where('documentId', isEqualTo: documentId).snapshots();
  }
}
