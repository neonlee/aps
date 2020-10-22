import 'package:aps/Controller/ComunityPostController.dart';
import 'package:aps/Models/ComunityPost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditComunityPostPage extends StatefulWidget {
  final String uid;
  EditComunityPostPage({Key key, this.uid}) : super(key: key);
  @override
  _EditComunityPostPageState createState() => _EditComunityPostPageState();
}

class _EditComunityPostPageState extends State<EditComunityPostPage> {
  ComunityPostController comunityPostController = ComunityPostController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder(
            future: comunityPostController.list().doc('${widget.uid}').get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              TextEditingController description =
                  TextEditingController(text: snapshot.data['description']);
              TextEditingController title =
                  TextEditingController(text: snapshot.data['title']);

              if (!snapshot.hasData) return CircularProgressIndicator();
              return Container(
                padding: EdgeInsets.all(15),
                child: ListView(
                  children: <Widget>[
                    TextFormField(
                      controller: title,
                    ),
                    TextFormField(
                      controller: description,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.amber[800],
                      child: FlatButton(
                        onPressed: () {
                          String user = FirebaseAuth.instance.currentUser.uid;
                          ComunityPost comunityPost = ComunityPost(
                              description: description.text,
                              title: title.text,
                              uid: user);
                          comunityPostController.update(
                              widget.uid, comunityPost);
                          Navigator.pushNamed(context, '/bodypagenavigator/2');
                        },
                        child: Text("Salvar"),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
