import 'package:flutter/material.dart';
import 'package:aps/Controller/FinanceController.dart';
import 'package:aps/Models/Finance.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddFinance extends StatefulWidget {
  @override
  _AddFinanceState createState() => _AddFinanceState();
}

class _AddFinanceState extends State<AddFinance> {
  String _value = "Divida";
  String labelData = "Data de endivamento ou vencimento";
  TextEditingController description = TextEditingController();
  TextEditingController type = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController value = TextEditingController();
  TextEditingController date = TextEditingController();
  var valueMask = new MaskTextInputFormatter(
      mask: 'R\$###,##', filter: {"#": RegExp(r'[0-9]')});

  var dateMask = new MaskTextInputFormatter(
      mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              "Cadastre suas Finanças",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
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
            TextField(
              controller: name,
              decoration: InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: description,
              decoration: InputDecoration(labelText: "Descrição"),
            ),
            TextField(
              inputFormatters: [dateMask],
              keyboardType: TextInputType.datetime,
              controller: date,
              decoration: InputDecoration(labelText: labelData),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: value,
              inputFormatters: [valueMask],
              decoration: InputDecoration(labelText: "Valor"),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
                onPressed: () {
                  Finance finance = Finance(
                    date: date.text,
                    description: description.text,
                    name: name.text,
                    type: _value,
                    value: value.text,
                  );
                  FinanceController financeController = FinanceController();
                  financeController.add(finance);
                  Navigator.pushNamed(context, '/bodypagenavigator/2');
                },
                child: Text("Salvar"))
          ],
        ),
      ),
    );
  }
}
