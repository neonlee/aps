import 'package:aps/Controller/FinanceController.dart';
import 'package:aps/Models/Finance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EditFinancePage extends StatefulWidget {
  final String uid;
  EditFinancePage({Key key, this.uid}) : super(key: key);
  @override
  _EditFinancePageState createState() => _EditFinancePageState();
}

class _EditFinancePageState extends State<EditFinancePage> {
  String labelData = "Data de endivamento ou vencimento";
  FinanceController financeController = FinanceController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(15),
        child: FutureBuilder(
            future: financeController.list().doc('${widget.uid}').get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              String _value = snapshot.data["type"];
              TextEditingController description =
                  TextEditingController(text: snapshot.data["description"]);
              TextEditingController name =
                  TextEditingController(text: snapshot.data["name"]);
              TextEditingController value =
                  TextEditingController(text: snapshot.data["value"]);
              TextEditingController date =
                  TextEditingController(text: snapshot.data["date"]);

              if (!snapshot.hasData) return CircularProgressIndicator();
              return Container(
                padding: EdgeInsets.all(15),
                child: ListView(
                  children: <Widget>[
                    DropdownButton(
                        value: _value,
                        isExpanded: true,
                        items: [
                          DropdownMenuItem(
                            child: Text("Divida"),
                            value: "Divida",
                          ),
                          DropdownMenuItem(
                            child: Text("Investido"),
                            value: "Investimento",
                          ),
                          DropdownMenuItem(
                            child: Text("Recebido"),
                            value: "Recebimento",
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value = value;
                            switch (_value) {
                              case "Divida":
                                labelData = "Data de endivamento ou vencimento";
                                break;
                              case "Investimento":
                                labelData = "Data do Investimento";
                                break;
                              case "Recebimento":
                                labelData = "Data do Recebimento";
                                break;
                              default:
                            }
                          });
                        }),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: value,
                    ),
                    TextFormField(
                      controller: name,
                    ),
                    TextFormField(
                      controller: description,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.datetime,
                      controller: date,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: Colors.amber[800],
                      child: FlatButton(
                        onPressed: () {
                          Finance finance = Finance(
                            date: date.text,
                            description: description.text,
                            name: name.text,
                            type: _value,
                            value: value.text,
                          );

                          financeController.update(widget.uid, finance);
                          Navigator.pushNamed(context, '/bodypagenavigator/2');
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
