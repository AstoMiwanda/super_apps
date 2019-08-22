import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:super_apps/ui/absen_page.dart';
import 'package:super_apps/ui/main_menu_page.dart';
import 'package:super_apps/ui/profile_page.dart';
import 'package:super_apps/ui/lihat_kantor_page.dart';
import 'package:super_apps/style/theme.dart' as Theme;
import 'package:super_apps/ui/human_capital_page.dart';
import 'package:super_apps/ui/report_absen_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Apps',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  Widget callPage(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return MainMenu();
        break;
      case 1:
        return FingerPrintAbsen();
        break;
      case 2:
        return Profile();
        break;
      default:
        return MainMenu();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: callPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            title: Text('Absen'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan,
        onTap: _onItemTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
