import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:super_apps/api/api.dart' as api;


class NotificationPage extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  new _Notification();
  }

  }

class _Notification  extends State<NotificationPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Text("hallo"),
    );
  }

  @override
  void initState() {
    super.initState();
    getDataNotif();
  }


}

void getDataNotif () async {
  var nik = "955139";
  final uri = api.Api.notification + "$nik/1";
  final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
  Response response = await get(uri, headers: headers);
  var data = jsonDecode(response.body);
  var data_profile = (data["data"] as List)
      .map((data) => new dataNotification.fromJson(data))
      .toList();
  foreachHasil(data_profile);
}

void foreachHasil(List<dataNotification> data_notification) {
  print(data_notification.length);

  for(int i = 0;i < data_notification.length;i++){
    print(data_notification[i].title);
  }
}

class dataNotification {
  String nik;
  String title;
  String message;
  String status_opened;

  dataNotification(
      {this.nik,
        this.title,
        this.message,
        this.status_opened});

  factory dataNotification.fromJson(Map<String, dynamic> parsedJson) {
    return dataNotification(
      nik: parsedJson['nik'].toString(),
      title: parsedJson['title'].toString(),
      message: parsedJson['message'].toString(),
      status_opened: parsedJson['status_opened'].toString()
    );
  }
}