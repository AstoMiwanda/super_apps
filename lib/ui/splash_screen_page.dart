import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_apps/api/api.dart' as api;
import 'package:super_apps/style/string.dart' as string;
import 'package:splashscreen/splashscreen.dart';
import 'package:super_apps/ui/login_page.dart';
import 'package:super_apps/ui/tabs/menu.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPage createState() => new _SplashScreenPage();
}

class _SplashScreenPage extends State<SplashScreenPage> {
Timer _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _AnimatedFlutterLogoState();
  }
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 14,
      navigateAfterSeconds: new AfterSplash(),
      title: new Text('',
        style: new TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0
        ),
      ),
      image: new Image.network(string.text.uri_splash_screen),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: ()=>print("Flutter Egypt"),
      loaderColor: Colors.red,
    );
  }

  _AnimatedFlutterLogoState() {
    _timer = new Timer( const Duration( seconds: 5, ), () {
      Islogin();
    } );
  }

  Future Islogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var login = (prefs.getString("username") ?? '');
    if (login != '') {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => new Menu()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => new Login()));
    }
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(""),
        automaticallyImplyLeading: false,
      ),
      body: new Center(
        child: new Text("",
          style: new TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0
          ),),

      ),
    );
  }
}