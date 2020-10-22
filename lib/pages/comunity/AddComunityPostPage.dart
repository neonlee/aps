import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aps/Controller/ComunityPostController.dart';
import 'package:aps/Models/ComunityPost.dart';

class AddComunityPostPage extends StatefulWidget {
  @override
  _AddComunityPostPageState createState() => _AddComunityPostPageState();
}

class _AddComunityPostPageState extends State<AddComunityPostPage> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Center(
              child: Text(
                "Criando seu post",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: title,
              decoration: InputDecoration(labelText: "Título do post"),
            ),
            TextField(
              controller: description,
              decoration: InputDecoration(labelText: "Descrição do post"),
            ),
            SizedBox(
              height: 15,
            ),
            OutlineButton.icon(
                onPressed: () {},
                icon: Icon(Icons.image),
                label: Text("Insira uma imagem")),
            SizedBox(
              height: 15,
            ),
            FlatButton(
                onPressed: () {
                  String user = FirebaseAuth.instance.currentUser.uid;
                  ComunityPost comunityPost = ComunityPost(
                      uid: user,
                      title: title.text,
                      description: description.text);
                  ComunityPostController comunityPostController =
                      ComunityPostController();
                  comunityPostController.add(comunityPost);
                  Navigator.pushNamed(context, '/comunitypostlist');
                },
                child: Text("Salvar"))
          ],
        ),
      ),
    );
  }
}
