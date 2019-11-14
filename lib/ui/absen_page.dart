import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:super_apps/style//theme.dart' as theme;
import 'package:intl/intl.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:location/location.dart';
import 'package:super_apps/api/api.dart' as api;
import 'package:super_apps/style/string.dart' as string;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

DateTime now = DateTime.now();
Timer _timer;
int _start = 10;
String formattedDate = DateFormat('kk:mm').format(now);
String imei;
String jenisAbsen = 'masuk';
String jam_masuk = '-';
String jam_pulang = '-';
String message = '';
String nik = '';
String onLocation = 'NOK';
bool showToast = false;
Location location = Location();
Map<String, double> currentLocation;
ProgressDialog pr;

class Absen extends StatefulWidget {
  Absen({Key key}) : super(key: key);

  _Absen createState() => new _Absen();
}

class _Absen extends State<Absen> {
  String _timeString;
  var data;
  static const platform = const MethodChannel('samples.flutter.io/location');
  bool mocklocation = false;

  getNik() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nik = (prefs.getString('username') ?? '');
    });
    getStatusMasuk();
  }

  getImei() async {
    var imeiId = await ImeiPlugin.getImei();
    setState(() {
      imei = imeiId;
    });
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  Widget _statusOnLocation() {
    onLocation = authLocation();
    if (onLocation == 'NOK') {
      return Container(
        width: 24.0,
        height: 24.0,
        decoration: new BoxDecoration(
          color: theme.Colors.colorNotOnLocation,
          shape: BoxShape.circle,
        ),
      );
    } else {
      return Container(
        width: 24.0,
        height: 24.0,
        decoration: new BoxDecoration(
          color: theme.Colors.colorOnLocation,
          shape: BoxShape.circle,
        ),
      );
    }
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void _showDialog({String type, String message = ''}) {
//    type = 'complete';
    String icon;
    String msg;
    if (type == 'masuk') {
      icon = string.Icons.icon_absen_masuk;
      msg = string.Message.msg_absen_masuk;
    } else if (type == 'pulang') {
      icon = string.Icons.icon_absen_pulang;
      msg = string.Message.msg_absen_pulang;
    } else if (type == 'complete') {
      icon = string.Icons.icon_absen_complete;
      msg = string.Message.msg_absen_complete;
    } else {
      icon = string.Icons.icon_locked_apps;
      msg = message;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 5), () {
          Navigator.of(context).pop(true);
        });
        return AlertDialog(
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
                  icon,
                  placeholderBuilder: (context) => Icon(Icons.error),
                  fit: BoxFit.fitHeight,
                ),
//                child: Image.network('https://thumbs.gfycat.com/DistortedElaborateFairybluebird-size_restricted.gif'),
              ),
              Text(
                '${msg}',
                style: TextStyle(
                    color: theme.Colors.backgroundHumanCapital,
                    fontSize: 16.0,
                    height: 1.5),
                textAlign: TextAlign.center,
              )
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _timeString = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(minutes: 1), (Timer t) => _getTime());
    super.initState();
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    location.onLocationChanged().listen((value) {
      setState(() {
        currentLocation = value;
      });
    });
    if (nik != '')
      getStatusMasuk();
    getNik();
    getImei();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  authLocation() {
    var loc;
    currentLocation == null ? loc = "NOK" : loc = "OK";
    return loc;
  }

  _postAbsen() async {
    onLocation = authLocation();
    print(onLocation);
    if (onLocation == 'OK') {
      pr.show();
      final uri = api.Api.absen;
      print(uri);
      print("nik: "+nik);
      print("imei: "+imei);
      print("latitude: "+currentLocation["latitude"].toString());
      print("longitude: "+currentLocation["longitude"].toString());
      print("jenis_absen: "+jenisAbsen);
      final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
      final encoding = Encoding.getByName('utf-8');

      Response response = await post(
        uri,
        headers: headers,
        body: "nik=" +
            nik +
            "&imei=" +
            imei +
            "&latitude=" +
            currentLocation["latitude"].toString() +
            "&longitude=" +
            currentLocation["longitude"].toString() +
            "&jenis_absen=" +
            jenisAbsen,
        encoding: encoding,
      );
      print(json.decode(response.body));
      pr.hide();
      final dataResponse = json.decode(response.body);
      message = dataResponse['message'];
//      Toast.show(message, context,
//          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      if (dataResponse['status']) {
        _showDialog(type: jenisAbsen);
        getStatusMasuk();
      } else {
        _showDialog(type: 'error', message: message);
        startTimer();
      }
      startTimer();
    } else {
      message = string.Message.msg_lokasi_tidak_ada;
//      Toast.show(message, context,
//          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      _showDialog(type: 'error', message: message);
      startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    getImei();
    double widthDevice = MediaQuery.of(context).size.width;
    double heightDevice = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                color: theme.Colors.backgroundAbsen,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: heightDevice -
                              (statusBarHeight + heightDevice * 0.06)),
                      child: Container(
                        padding: EdgeInsets.only(top: heightDevice * 0.06),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
//                          mainAxisSize: MainAxisSize.max,
//                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 3, // 20%
                                          child: Center(
                                              child: Text("Belum Absen",
                                                  style: TextStyle(
                                                      color: Colors.white)))
                                          //Text("Belum Absen", style: TextStyle(color: Colors.white))
                                          ),
                                      Expanded(
                                        flex: 4,
                                        child: Text(" "),
                                      ),
                                      Expanded(
                                        flex: 3, // 20%
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  child: Center(
                                                    child: Text("Absen Pulang",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                    margin: EdgeInsets.only(
                                                        left: 33.0),
                                                    child: Text(jam_pulang,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white))),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(
                                        left: 50.0,
                                      ),
                                      width: 20.0,
                                      height: 20.0,
                                      decoration: new BoxDecoration(
                                        color: (jenisAbsen == 'masuk' ||
                                                jenisAbsen == 'pulang' ||
                                                jenisAbsen == 'complete')
                                            ? Color(0xFFC1E4ED)
                                            : Colors.white38,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Expanded(
                                      child: new Container(
                                          child: Divider(
                                        thickness: 4,
                                        color: (jenisAbsen == 'pulang' ||
                                                jenisAbsen == 'complete')
                                            ? Color(0xFFC1E4ED)
                                            : Color(0xFF31A5C4),
                                        height: 36,
                                      )),
                                    ),
                                    Container(
                                      width: 20.0,
                                      height: 20.0,
                                      decoration: new BoxDecoration(
                                        color: (jenisAbsen == 'pulang' ||
                                                jenisAbsen == 'complete')
                                            ? Color(0xFFC1E4ED)
                                            : Colors.white38,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    //Text("OR", style: TextStyle(color: Colors.white)),
                                    Expanded(
                                      child: new Container(
                                          child: Divider(
                                        thickness: 3,
                                        color: jenisAbsen == 'complete'
                                            ? Color(0xFFC1E4ED)
                                            : Color(0xFF31A5C4),
                                        height: 36,
                                      )),
                                    ),
                                    Container(
                                      margin:
                                          const EdgeInsets.only(right: 50.0),
                                      width: 20.0,
                                      height: 20.0,
                                      decoration: new BoxDecoration(
                                        color: jenisAbsen == 'complete'
                                            ? Color(0xFFC1E4ED)
                                            : Colors.white38,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ]),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Center(
                                            child: Text("Absen Masuk",
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          )),
                                      //Text("Belum Absen", style: TextStyle(color: Colors.white))
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Center(
                                            child: Text(jam_masuk,
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                    color: Colors.white)),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
//                              padding:  EdgeInsets.only(top: 60),
                              //height: 20.0,
                              child: Row(
                                children: <Widget>[
                                  Builder(
                                    builder: (context) => GestureDetector(
                                      onTap: () {
                                        _postAbsen();
                                      },
                                      child: Container(
                                        width: widthDevice,
                                        child: Image.asset(
                                            string.Images.uri_absen_masuk),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
//                            Container(
//                              child: Row(
//                                mainAxisAlignment: MainAxisAlignment.center,
//                                children: <Widget>[
//                                  Container(
//                                    margin: EdgeInsets.only(top: 32),
//                                    child: Text(absenTitle,
//                                        style: TextStyle(
//                                            fontSize: 24,
//                                            color: Colors.white,
//                                            fontWeight: FontWeight.bold)),
//                                  )
//                                ],
//                              ),
//                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  getStatusMasuk() async {
    final uri = api.Api.status_absen + "$nik";
    print(uri);
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Response response = await get(uri, headers: headers);
    var data = jsonDecode(response.body);
    var data_profile = (data["data"] as List)
        .map((data) => new dataProfile.fromJson(data))
        .toList();
    foreachHasil(data_profile);
  }

  void foreachHasil(List<dataProfile> data_profile) {
    for (var ini = 0; ini < data_profile.length; ini++) {
      //TODO setstate

      print("status absen: "+data_profile[ini].status_absen);
      var status;
      setState(() {
        // provide data astro
        status = data_profile[ini].status_absen;
        if (data_profile[ini].jam_masuk != 'null')
          jam_masuk = data_profile[ini].jam_masuk.toString();
        if (data_profile[ini].jam_pulang != 'null')
          jam_pulang = data_profile[ini].jam_pulang.toString();

        if (status == 'belum masuk') {
          jenisAbsen = 'masuk';
        } else if (status == 'sudah masuk') {
          jenisAbsen = 'pulang';
        } else if (status == 'sudah pulang') {
          jenisAbsen = 'complete';
        } else {
          jenisAbsen = 'masuk';
        }
      });
    }
  }
}

class dataProfile {
  String status_absen;
  String jam_masuk;
  String jam_pulang;

  dataProfile({
    this.status_absen,
    this.jam_masuk,
    this.jam_pulang,
  });

  factory dataProfile.fromJson(Map<String, dynamic> parsedJson) {
    return dataProfile(
      status_absen: parsedJson['status_absen'].toString(),
      jam_masuk: parsedJson['jam_masuk'].toString(),
      jam_pulang: parsedJson['jam_pulang'].toString(),
    );
  }
}
