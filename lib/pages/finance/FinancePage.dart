import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:aps/Controller/FinanceController.dart';

class FinancePage extends StatefulWidget {
  @override
  _FinancePageState createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  FinanceController finance = FinanceController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        child: StreamBuilder<QuerySnapshot>(
          stream: finance.list().snapshots(),
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
                return Card(
                  child: Column(
                    children: [
                      new ListTile(
                        title: new Text(
                            "R\$ " + document.data()['value'].toString()),
                        subtitle: new Text(document.data()['name']),
                      ),
                      Row(
                        children: [
                          FlatButton.icon(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/financeview/${document.id}');
                            },
                            label: Text("Visualizar"),
                          ),
                          FlatButton.icon(
                            icon: Icon(Icons.border_color),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/financeedit/${document.id}');
                            },
                            label: Text("Editar"),
                          ),
                          FlatButton.icon(
                              onPressed: () {
                                FinanceController financeController =
                                    FinanceController();
                                financeController.delete(document.id);
                              },
                              icon: Icon(Icons.cancel),
                              label: Text("Excluir")),
                        ],
                      )
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/addfinance');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
