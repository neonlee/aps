import 'package:aps/Controller/ComunityPostController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewComunityPostPage extends StatefulWidget {
  final String uid;
  ViewComunityPostPage({Key key, this.uid}) : super(key: key);
  @override
  _ViewComunityPostPageState createState() => _ViewComunityPostPageState();
}

class _ViewComunityPostPageState extends State<ViewComunityPostPage> {
  ComunityPostController comunityPostController = ComunityPostController();
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
