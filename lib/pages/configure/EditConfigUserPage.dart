import 'package:aps/Controller/UserController.dart';
import 'package:aps/Models/User.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditConfigUserPage extends StatefulWidget {
  final String uid;
  EditConfigUserPage({Key key, this.uid}) : super(key: key);
  @override
  _EditConfigUserPageState createState() => _EditConfigUserPageState();
}

class _EditConfigUserPageState extends State<EditConfigUserPage> {
  UserController userController = UserController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder(
            future: userController.list().get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              TextEditingController year =
                  TextEditingController(text: snapshot.data['year']);
              TextEditingController email =
                  TextEditingController(text: snapshot.data['email']);
              TextEditingController name =
                  TextEditingController(text: snapshot.data['name']);
              TextEditingController users =
                  TextEditingController(text: snapshot.data['user']);
              TextEditingController password =
                  TextEditingController(text: snapshot.data['password']);
              if (!snapshot.hasData) return CircularProgressIndicator();
              return Container(
                padding: EdgeInsets.all(15),
                child: ListView(
                  children: <Widget>[
                    TextField(
                      controller: email,
                    ),
                    TextField(
                      controller: password,
                      enabled: true,
                      obscureText: true,
                    ),
                    TextField(
                      controller: name,
                    ),
                    TextField(
                      controller: users,
                    ),
                    TextField(
                      controller: year,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: FlatButton(
                        onPressed: () {
                          Users user1 = new Users(
                              email: email.text,
                              name: name.text,
                              password: password.text,
                              user: users.text,
                              year: year.text);
                          userController.update(widget.uid, user1);
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
