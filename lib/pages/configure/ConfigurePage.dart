import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aps/Models/SignUp.dart';

class ConfigurePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          OutlineButton.icon(
              onPressed: () {
                String user = FirebaseAuth.instance.currentUser.uid;
                Navigator.pushNamed(context, '/edituser/' + user);
                print(user);
              },
              icon: Icon(Icons.person),
              label: Text("Configurações de conta")),
          OutlineButton.icon(
              onPressed: () {
                deleteUser()
                    .whenComplete(() => Navigator.pushNamed(context, '/'));
              },
              icon: Icon(Icons.delete),
              label: Text("Deletar sua conta")),
          OutlineButton(
              onPressed: () {
                signOut().whenComplete(() => Navigator.pushNamed(context, '/'));
              },
              child: Text("Sair")),
        ],
      ),
    );
  }
}
