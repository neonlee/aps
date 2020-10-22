import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Login')),
            FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text('Fazer cadastro')),
          ],
        ),
      ),
    );
  }
}
