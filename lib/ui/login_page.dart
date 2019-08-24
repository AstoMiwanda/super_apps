import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_apps/style//theme.dart' as theme;
import 'package:super_apps/style//string.dart' as string;
import 'package:super_apps/ui/tabs/menu.dart';
import 'package:toast/toast.dart';
import 'package:super_apps/api/api.dart' as api;


TextEditingController usernameController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();
BuildContext ctx;
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  _Login createState() => new _Login();
}

void showInSnackBar(String value) {
  _scaffoldKey.currentState
      .showSnackBar(new SnackBar(content: new Text(value)));
}

class _Login extends State<Login> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ctx = context;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: theme.Colors.backgroundLogin,
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              color: theme.Colors.backgroundLogin,
              margin: const EdgeInsets.only(top: 0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: new Image(
                        image:
                            new AssetImage(string.text.uri_login_header)),
                    alignment: Alignment.center,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    width: 300,
                    child: Column(
                      children: <Widget>[
                        TextField(
                          decoration: InputDecoration(
                              hintText: string.text.hint_text,
                              icon: Icon(Icons.account_circle),
                              hintStyle:
                                  TextStyle(color: theme.Colors.colorTextWhite),
                              labelText: string.text.lbl_username,
                              fillColor: theme.Colors.colorTextWhite,
                              labelStyle: TextStyle(
                                  color: theme.Colors.colorTextWhite)),
                          keyboardType: TextInputType.text,
                          controller: usernameController,
                          style: TextStyle(color: theme.Colors.colorTextWhite),
                        ),
                        TextField(
                            decoration: InputDecoration(
                                icon: Icon(Icons.lock),
                                hintText: string.text.hint_password,
                                hintStyle: TextStyle(
                                    color: theme.Colors.colorTextWhite),
                                labelText: string.text.lbl_password,
                                fillColor: theme.Colors.colorTextWhite,
                                labelStyle: TextStyle(
                                    color: theme.Colors.colorTextWhite)),
                            obscureText: true,
                            controller: passwordController,
                            style:
                                TextStyle(color: theme.Colors.colorTextWhite))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: 150,
                    child: Container(
                      child: new RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        onPressed: () async {
                          makePostRequest(usernameController.text.toString(),
                              passwordController.text.toString());
                        },
                        child: Text(string.text.lbl_login),
                        color: theme.Colors.bacgroundButton,
                        textColor: theme.Colors.colorTextWhite,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  void makePostRequest(username, password) async {
    final uri = api.Api.login;
    print("url ::" + uri + "/" + username);
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    final encoding = Encoding.getByName('utf-8');

    Response response = await post(
      uri,
      headers: headers,
      body: "username=${username}&password=${password}",
      encoding: encoding,
    );

    String responseBody = response.body;
    bool status = json.decode(responseBody)["status"];
    var message = json.decode(responseBody)["message"];

    if (status) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('username', username);
      prefs.commit();
      Navigator.push(
        ctx,
        MaterialPageRoute(builder: (context) => new Menu()),
      );
    } else {
      Toast.show(message, ctx,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }
  }

  Future Islogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var login = (prefs.getString("username") ?? '');
    if (login != '') {
      Navigator.pushReplacement(
          ctx, MaterialPageRoute(builder: (context) => new Menu()));
    }
  }

  @override
  void initState() {
    super.initState();
    Islogin();
  }
}