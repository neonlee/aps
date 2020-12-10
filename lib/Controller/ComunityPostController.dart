import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:aps/Models/ComunityPost.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

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

  FirebaseStorage _storage = FirebaseStorage.instance;
//Creating a global Variable
  StorageReference storageReference = FirebaseStorage.instance.ref();
  File _image;
  final picker = ImagePicker();

  void getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  }

  Widget getImageU() {
    return _image == null
        ? Text('No image selected.')
        : Image.network(
            _image.path,
            fit: BoxFit.contain,
          );
  }

  void addImageToFirebase() async {
    //CreateRefernce to path.
    StorageReference ref = storageReference.child("yourstorageLocation/");

    //StorageUpload task is used to put the data you want in storage
    //Make sure to get the image first before calling this method otherwise _image will be null.

    StorageUploadTask storageUploadTask =
        ref.child("image1.jpg").putFile(_image);

    if (storageUploadTask.isSuccessful || storageUploadTask.isComplete) {
      final String url = await ref.getDownloadURL();
      print("The download URL is " + url);
    } else if (storageUploadTask.isInProgress) {
      storageUploadTask.events.listen((event) {
        double percentage = 100 *
            (event.snapshot.bytesTransferred.toDouble() /
                event.snapshot.totalByteCount.toDouble());
        print("THe percentage " + percentage.toString());
      });

      StorageTaskSnapshot storageTaskSnapshot =
          await storageUploadTask.onComplete;
      var downloadUrl1 = await storageTaskSnapshot.ref.getDownloadURL();

      //Here you can get the download URL when the task has been completed.
      print("Download URL " + downloadUrl1.toString());
    } else {
      //Catch any cases here that might come up like canceled, interrupted
    }
  }
}
