import 'package:flutter/material.dart';
import 'package:aps/pages/comunity/ComunityListPostPage.dart';
import 'package:aps/pages/configure/ConfigurePage.dart';
import 'package:aps/pages/finance/FinancePage.dart';

class BodyPageNavigator extends StatefulWidget {
  final String page;
  BodyPageNavigator({Key key, this.page}) : super(key: key);
  @override
  _BodyPageNavigatorState createState() => _BodyPageNavigatorState();
}

class _BodyPageNavigatorState extends State<BodyPageNavigator> {
  int _selectedIndex = 0;

  TextStyle optionStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
  Text title;
  Color appBarColor;
  List<Widget> _widgetOptions = [
    Text("Data1"),
    FinancePage(),
    ComunityPostPage(),
    ConfigurePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          title = Text('');
          break;
        case 1:
          title = Text('Finanças');
          break;
        case 2:
          title = Text('Comunidade');

          break;
        case 3:
          title = Text('Configurações');
          break;
        default:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart),
            label: 'Finanças',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Comunidade',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
