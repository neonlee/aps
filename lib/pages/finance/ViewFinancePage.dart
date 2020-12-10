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
      appBar: AppBar(
        title: Text(
          "Detalhes de sua conta",
        ),
      ),
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
              Color color;
              switch (data['type']) {
                case "Investimento":
                  color = Colors.green;
                  break;
                case "Divida":
                  color = Colors.red;
                  break;
                case "Recebimento":
                  color = Colors.blueAccent;
                  break;
                default:
              }
              return ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width * 0.15,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            "${data['type']}",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            "Data: ${data['date']}",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        )
                      ],
                    ),
                    color: color,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Valor: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 110,
                      ),
                      Text("R\$${data['value']}")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Nome da conta:",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text("${data['name']}"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Descrição: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text("${data['description']}"),
                    ],
                  ),
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
