import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_apps/api/api.dart' as api;
import 'package:splashscreen/splashscreen.dart';
import 'package:super_apps/ui/login_page.dart';
import 'package:super_apps/ui/tabs/menu.dart';
import 'package:super_apps/style/theme.dart' as theme;
import 'package:super_apps/style/string.dart' as string;

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPage createState() => new _SplashScreenPage();
}

class _SplashScreenPage extends State<SplashScreenPage> {
  var login;
  var is_active = '0';
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
      seconds: 16,
      navigateAfterSeconds: new AfterSplash(),
      title: new Text(
        '',
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: new Image.network(
          api.Api.logo_apps),
      backgroundColor: Colors.white,
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      onClick: () => print("Flutter Egypt"),
      loaderColor: Colors.red,
    );
  }

  _AnimatedFlutterLogoState() {
    _timer = new Timer(
        const Duration(
          seconds: 5,
        ), () {
      Islogin();
    });
  }

  Future Islogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    login = (prefs.getString("username") ?? '');
    print("username : "+login);
    if (login != '') {
      getStatusAbsen(login);
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => new Login()));
    }
  }

  getStatusAbsen(username) async {
    final uri           = api.Api.auth_user_active;
    print(uri);
    print(username);
    final headers       = {'Content-Type': 'application/x-www-form-urlencoded'};
    final encoding      = Encoding.getByName('utf-8');
    Response response   = await post(
      uri,
      headers: headers,
      body: "username=" + username,
      encoding: encoding,
    );
    var data          = jsonDecode(response.body);
    var data_notif    = data["data"];
    print(data_notif);
    var data_profile  = (data["data"] as List)
        .map((data) => new dataStatusAbsen.fromJson(data))
        .toList();
//    print(data_profile);
    is_active = foreachStatusAbsen(data_profile);
    if (is_active == '1'){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => new Menu()));
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', '');
      prefs.commit();
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => new Login()));
    }
  }

  foreachStatusAbsen(List<dataStatusAbsen> data_notification) {
    for (var ini = 0; ini < data_notification.length; ini++) {
      //TODO setstate
      return data_notification[ini].status;
    }
  }

  goToLogin(){
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => new Login()));
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
      body: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
        contentPadding:
        EdgeInsets.symmetric(vertical: 46.0, horizontal: 16.0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 120.0,
              margin: EdgeInsets.only(bottom: 32.0),
              child: SvgPicture.asset(
                string.Icons.icon_locked_apps,
                placeholderBuilder: (context) => Icon(Icons.error),
                fit: BoxFit.fitHeight,
              ),
//                child: Image.network('https://thumbs.gfycat.com/DistortedElaborateFairybluebird-size_restricted.gif'),
            ),
            Text(
              string.Message.msg_cek_koneksi_internet,
              style: TextStyle(
                  color: theme.Colors.backgroundHumanCapital,
                  fontSize: 16.0,
                  height: 1.5),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class dataStatusAbsen {
  String status;

  dataStatusAbsen({this.status});

  factory dataStatusAbsen.fromJson(Map<String, dynamic> parsedJson) {
    return dataStatusAbsen(
        status: parsedJson['status'].toString());
  }
}