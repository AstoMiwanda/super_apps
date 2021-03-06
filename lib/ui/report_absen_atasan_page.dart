import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_apps/ui/report_absen_atasan_detail_page.dart';
import 'package:super_apps/style/theme.dart' as theme;
import 'package:super_apps/style/string.dart' as string;
import 'package:super_apps/api/api.dart' as api;
import 'package:toast/toast.dart';

int lengthListAbsen = 0;
String username = '';
String today = '';
List<dataAbsensi> list_absensi;
BuildContext ctx;
ProgressDialog pr;

class ReportAbsenAtasan extends StatefulWidget {
  @override
  _ReportAbsenAtasanState createState() => _ReportAbsenAtasanState();
}

class _ReportAbsenAtasanState extends State<ReportAbsenAtasan> {
  widgetListAbsensi({String nik, String name, String masuk}) {
    var ket;
    masuk == 'true' ? ket = 'Hadir' : ket = 'Belum Hadir';

    if (list_absensi == null) {
      return Container();
    } else if (list_absensi.length == 0) {
      return Container();
    } else {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReportAbsenAtasanDetail(
                  nik_bawahan: nik,
                ),
              ));
        },
        child: Card(
          margin: EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 0.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: <Widget>[
                /*
                Container(
                  height: 46.0,
                  width: 46.0,
                  margin: EdgeInsets.only(right: 16.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue,
                      ),
                  child: SvgPicture.asset(
                    string.Icons.icon_profile,
                    placeholderBuilder: (context) => Icon(Icons.error),
                    fit: BoxFit.fitHeight,
                  ),
                ),

                 */
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        nik,
                        style: TextStyle(
                            color: theme.Colors.colorTextBlackReportAbsenAtasan,
                            fontWeight: FontWeight.normal,
                            fontSize: 12.4),
                      ),
                      Text(
                        name,
                        style: TextStyle(
                            color: theme.Colors.colorTextBlackReportAbsenAtasan,
                            fontWeight: FontWeight.w600,
                            fontSize: 13.8),
                      )
                    ],
                  ),
                ),
                Container(
                  height: 56.0,
                  width: 110.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 16.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: masuk == 'true'
                                ? Colors.blue
                                : Colors.yellow[600],
                            borderRadius: BorderRadius.circular(26.0)),
                        child: Text(
                          ket,
                          style: TextStyle(color: Colors.white, fontSize: 13.0),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    getNik();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.Colors.backgroundHumanCapital,
        title: Text(string.Text.page_report_absen_atasan,
            style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: <Widget>[],
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Card(
                  margin: EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 0.0),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          today,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (list_absensi == null) {
                    return widgetListAbsensi();
                  } else if (list_absensi.length == 0) {
                    return widgetListAbsensi();
                  } else {
                    return widgetListAbsensi(
                        nik: list_absensi[index].nik,
                        name: list_absensi[index].name,
                        masuk: list_absensi[index].masuk);
                  }
                },
                childCount: list_absensi == null
                    ? 1
                    : list_absensi.length == 0 ? 1 : list_absensi.length,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getNik() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('username') ?? '');
      listAbsenBawahan();
    });
  }

  listAbsenBawahan() async {
    pr.show();
    final uri = api.Api.list_absen_bawahan + "$username/1";
    print(uri);
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Response response = await get(uri, headers: headers);
    var data = jsonDecode(response.body);
    var data_absen = (data["data"] as List)
        .map((data) => new dataAbsensi.fromJson(data))
        .toList();
    foreachHasil(data_absen);
    setState(() {
      today = data['today'];
    });
    pr.hide();
  }

  void foreachHasil(List<dataAbsensi> data_absensi) {
    setState(() {
      list_absensi = data_absensi;
    });
    pr.hide();
  }
}

class dataAbsensi {
  String nik;
  String name;
  String masuk;

  dataAbsensi({this.nik, this.name, this.masuk});

  factory dataAbsensi.fromJson(Map<String, dynamic> parsedJson) {
    return dataAbsensi(
      nik: parsedJson['nik'].toString(),
      name: parsedJson['name'].toString(),
      masuk: parsedJson['masuk'].toString(),
    );
  }
}
