import 'package:aps/Controller/CommentController.dart';
import 'package:aps/Controller/ComunityPostController.dart';
import 'package:aps/Controller/UserController.dart';
import 'package:aps/Models/Comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ViewComunityPostPage extends StatefulWidget {
  final String uid;
  ViewComunityPostPage({Key key, this.uid}) : super(key: key);
  @override
  _ViewComunityPostPageState createState() => _ViewComunityPostPageState();
}

class _ViewComunityPostPageState extends State<ViewComunityPostPage> {
  ComunityPostController comunityPostController = ComunityPostController();
  TextEditingController commentController = TextEditingController();
  CommentController controller = CommentController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder<DocumentSnapshot>(
          future: comunityPostController.list().doc('${widget.uid}').get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data.data();
              return Column(
                children: [
                  Center(
                    child: Text(
                      "${data['title']}",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text("${data['description']}"),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: TextFormField(
                      controller: commentController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            String user = FirebaseAuth.instance.currentUser.uid;
                            Comment comment = Comment(
                                comentario: commentController.text,
                                documentId: snapshot.data.id,
                                nomeUsuario: user);
                            controller.add(comment);
                          },
                        ),
                        hintText: "Comentar",
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: controller.list(snapshot.data.id),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Something went wrong'));
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: Text("Loading"));
                        }

                        return Card(
                          child: new ListView(
                            children: snapshot.data.docs
                                .map((DocumentSnapshot document) {
                              UserController userId = UserController();
                              return ListTile(
                                title: FutureBuilder<DocumentSnapshot>(
                                  future: userId
                                      .listUser(document.data()['nomeUsuario']),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<dynamic> snapshot) {
                                    if (!snapshot.hasData)
                                      return CircularProgressIndicator();

                                    return Text(
                                        "${snapshot.data.data()['user']}" ??
                                            "");
                                  },
                                ),
                                subtitle: Text(document.data()['comentario']),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }

            return Text("loading");
          },
        ),
      ),
    );
  }
}
