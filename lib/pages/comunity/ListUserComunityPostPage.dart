import 'package:aps/Controller/ComunityPostController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListComunityUserPost extends StatefulWidget {
  @override
  _ListComunityUserPostState createState() => _ListComunityUserPostState();
}

class _ListComunityUserPostState extends State<ListComunityUserPost> {
  ComunityPostController comunityPostController = ComunityPostController();
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: comunityPostController.listUserPost(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: Text("Loading"));
            }

            return new ListView(
              children: snapshot.data.docs.map((DocumentSnapshot document) {
                return FlatButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, 'viewcomunitypost/${document.id}');
                  },
                  child: Card(
                    child: Column(
                      children: [
                        new ListTile(
                          title: Center(
                              child: new Text(
                            document.data()['description'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          subtitle: new Text(document.data()['title']),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FlatButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, 'editcomunitypost/${document.id}');
                              },
                              child: Text("Editar"),
                            ),
                            FlatButton(
                              onPressed: () {
                                comunityPostController.delete(document.id);
                              },
                              child: Text("Excluir"),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FlatButton.icon(
                              icon: Icon(Icons.thumb_up),
                              onPressed: () {},
                              label: Text("Curta"),
                            ),
                            FlatButton.icon(
                              icon: Icon(Icons.comment),
                              onPressed: () {},
                              label: Text("Comente"),
                            ),
                            FlatButton.icon(
                                onPressed: () {},
                                icon: Icon(Icons.share),
                                label: Text("Compartilhe")),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
