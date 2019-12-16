import 'dart:async';
import 'dart:core' as hack;
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:super_apps/style//theme.dart' as theme;
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:toast/toast.dart';
import '../absen_page.dart';
import '../main_menu_page.dart';
import '../profile_page.dart';
import 'package:super_apps/style/string.dart' as string;

class Menu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Menu();
  }
  
}

class _Menu extends State<Menu>{
  int _selectedIndex = 0;
  DateTime currentBackPressTime;
  DateTime now = DateTime.now();
  Location location = Location();
  Map<hack.String, double> currentLocation;
  Color icon_nav_bottom = Colors.cyan;

  Widget callPage(int selectedIndex) {
    selectedIndex == 1 ? authLocation() : disposeAuthLocation();
    switch (selectedIndex) {
      case 0:
        return MainMenu();
        break;
      case 1:
        return Absen();
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

  disposeAuthLocation() {
    setState(() {
      icon_nav_bottom = Colors.cyan;
    });
  }

  authLocation() {
    if (currentLocation == null) {
      setState(() {
        icon_nav_bottom = Colors.red;
      });
    } else {
      setState(() {
        icon_nav_bottom = Colors.green;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    location.onLocationChanged().listen((value) {
      setState(() {
        currentLocation = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentBackPressTime;

    return Scaffold(
      body: WillPopScope(
        child: callPage(_selectedIndex),
        onWillPop: onWillPop,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fingerprint),
            title: Text('Absent'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: icon_nav_bottom,
        onTap: _onItemTapped,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Toast.show(string.Message.msg_tap_again_to_exit, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      return Future.value(false);
    }
    return Future.value(true);
  }

}