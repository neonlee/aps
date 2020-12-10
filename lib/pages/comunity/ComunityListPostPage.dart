import 'package:animated_floatactionbuttons/animated_floatactionbuttons.dart';
import 'package:aps/Controller/ComunityPostController.dart';
import 'package:aps/Models/ComunityPost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ComunityPostPage extends StatefulWidget {
  @override
  _ComunityPostPageState createState() => _ComunityPostPageState();
}

class _ComunityPostPageState extends State<ComunityPostPage> {
  ComunityPostController comunityPostController = ComunityPostController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [FlatButton(onPressed: () {}, child: Text("data"))],
        ),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: comunityPostController.list().snapshots(),
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
                            document.data()['description'] ?? "",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          subtitle: new Text(document.data()['title'] ?? ""),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            FlatButton.icon(
                              icon: Icon(
                                Icons.thumb_up,
                                color: document.data()['like'] == 1
                                    ? Colors.blue
                                    : Colors.black,
                              ),
                              onPressed: () {
                                ComunityPost comunityPost = ComunityPost(
                                  description: document.data()['description'],
                                  title: document.data()['title'],
                                  uid: document.data()['uid'],
                                  like: document.data()['like'] == 1 ? 0 : 1,
                                );
                                comunityPostController.update(
                                    document.id, comunityPost);
                              },
                              label: Text("Curta"),
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
      floatingActionButton: AnimatedFloatingActionButton(
          //Fab list
          fabButtons: <Widget>[float1(), float2()],
          colorStartAnimation: Colors.blue,
          colorEndAnimation: Colors.red,
          animatedIconData: AnimatedIcons.menu_close //To principal button
          ),
    );
  }

  Widget float1() {
    return FloatingActionButton(
      heroTag: Text("btn1"),
      onPressed: () {
        Navigator.pushNamed(context, '/addcomunitypost');
      },
      tooltip: 'Adicionar post',
      child: Icon(Icons.add),
    );
  }

  Widget float2() {
    return FloatingActionButton(
      heroTag: Text("btn2"),
      onPressed: () {
        Navigator.pushNamed(context, '/listcomunityuserpost');
      },
      tooltip: 'Visualizar Seus Posts',
      child: Icon(Icons.remove_red_eye),
    );
  }
}
