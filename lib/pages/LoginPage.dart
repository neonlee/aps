import 'package:flutter/material.dart';
import 'package:aps/Models/SignUp.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextStyle style = TextStyle(color: Colors.white);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: email,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: password,
                enabled: true,
                obscureText: true,
                decoration: InputDecoration(labelText: "Senha"),
              ),
              RaisedButton(
                onPressed: () {
                  signIn(email.text, password.text).whenComplete(() =>
                      Navigator.pushNamed(context, '/bodypagenavigator/1'));
                },
                color: Colors.blue,
                child: Text(
                  "Entre",
                  style: style,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
