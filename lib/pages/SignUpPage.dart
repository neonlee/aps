import 'package:flutter/material.dart';
import 'package:aps/Controller/UserController.dart';
import 'package:aps/Models/SignUp.dart';
import 'package:aps/Models/User.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextStyle style = TextStyle(color: Colors.white);
  TextEditingController year = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController users = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Faça seu cadastro"),
      ),
      body: Container(
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
            TextField(
              controller: name,
              decoration: InputDecoration(labelText: "Nome Completo"),
            ),
            TextField(
              controller: users,
              decoration: InputDecoration(labelText: "Nome de usuário"),
            ),
            TextField(
              controller: year,
              decoration: InputDecoration(labelText: "Idade"),
            ),
            RaisedButton(
              onPressed: () {
                signUp(email.text, password.text).whenComplete(() {
                  Users user1 = new Users(
                      email: email.text,
                      name: name.text,
                      password: password.text,
                      user: users.text,
                      year: year.text);
                  UserController userControl = UserController();
                  userControl.add(user1);
                  Navigator.pushNamed(context, '/bodypagenavigator/1');
                });
              },
              color: Colors.blue,
              child: Text(
                "Cadastrar",
                style: style,
              ),
            ),
            Text(
              "Faça Login com outras rede sociais",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ButtonTheme(
              height: 30,
              minWidth: 150,
              child: RaisedButton(
                onPressed: () {},
                color: Colors.blue,
                child: Text(
                  "Login com facebook",
                  style: style,
                ),
              ),
            ),
            ButtonTheme(
              height: 30,
              minWidth: 160,
              child: RaisedButton(
                onPressed: () {},
                color: Colors.red,
                child: Text(
                  "Login com google",
                  style: style,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
