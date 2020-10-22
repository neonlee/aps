import 'package:aps/Controller/FinanceController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewFinancePage extends StatefulWidget {
  final String uid;
  ViewFinancePage({Key key, this.uid}) : super(key: key);
  @override
  _ViewFinancePageState createState() => _ViewFinancePageState();
}

class _ViewFinancePageState extends State<ViewFinancePage> {
  FinanceController finance = FinanceController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: FutureBuilder<DocumentSnapshot>(
          future: finance.list().doc('${widget.uid}').get(),
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
                    "Detalhes de sua conta",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  Container(
                    child: Text("${data['type']}"),
                    color: Colors.greenAccent,
                  ),
                  Text("Valor R\$${data['value']}"),
                  Text("Nome da conta: ${data['name']}"),
                  Text("Descrição: ${data['description']}"),
                  Text("Data: ${data['date']}"),
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
