import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'package:super_apps/api/api.dart' as api;
import 'package:super_apps/style//theme.dart' as theme;
import 'package:super_apps/style/string.dart' as string;
import 'package:super_tooltip/super_tooltip.dart';
import 'package:toast/toast.dart';

int lengthReportAbsen = 0;
List<String> tanggalAbsen = [];
List<String> jamMasukAbsen = [];
List<String> jamPulangAbsen = [];
List<String> ketAbsen = [];

ProgressDialog pr;

String nik = '';
SuperTooltip tooltip;
bool tooltips = false;
BuildContext ctx;

class ReportAbsenAtasanDetail extends StatefulWidget {
  @override
  _ReportAbsenAtasanDetailState createState() =>
      _ReportAbsenAtasanDetailState();
}

class _ReportAbsenAtasanDetailState extends State<ReportAbsenAtasanDetail> {
  GlobalKey _containerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    getNik();
  }

  getNik() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nik = (prefs.getString('username') ?? '');
    });
    makeGetRequest();
  }

  @override
  Widget build(BuildContext context) {
    void onTap() {
      if (tooltip != null && tooltip.isOpen) {
        tooltip.close();
        return;
      } else {
        tooltip.show(_containerKey.currentContext);
      }
    }

    ketWidgetAbsen(String ket) {
      Widget ketIcon;
      switch (ket) {
        case 'p':
          {
            return ketIcon = Container(
              color: Colors.greenAccent,
              height: 25.0,
              // height of the button
              width: 25.0,
              // width of the button
              child: Center(
                  child: Text('F', style: TextStyle(color: Colors.white))),
            );
          }
          break;
        case 'm':
          {
            return ketIcon = Container(
              color: Colors.grey,
              height: 25.0,
              // height of the button
              width: 25.0,
              // width of the button
              child: Center(
                  child: Text('M', style: TextStyle(color: Colors.white))),
            );
          }
          break;
        case 'f':
          {
            return ketIcon = Container(
              color: Colors.greenAccent,
              height: 25.0,
              // height of the button
              width: 25.0,
              // width of the button
              child: Center(
                  child: Text('F', style: TextStyle(color: Colors.white))),
            );
          }
          break;
        case 'w':
          {
            return ketIcon = Container(
              color: Colors.lightBlueAccent,
              height: 25.0,
              // height of the button
              width: 25.0,
              // width of the button
              child: Center(
                  child: Text('W', style: TextStyle(color: Colors.white))),
            );
          }
          break;
        case 'd':
          {
            return ketIcon = Container(
              color: Colors.green,
              height: 25.0,
              // height of the button
              width: 25.0,
              // width of the button
              child: Center(
                  child: Text('D', style: TextStyle(color: Colors.white))),
            );
          }
          break;
        case 's':
          {
            return ketIcon = Container(
              color: Colors.deepPurple,
              height: 25.0,
              // height of the button
              width: 25.0,
              // width of the button
              child: Center(
                  child: Text('S', style: TextStyle(color: Colors.white))),
            );
          }
          break;
        case 'c':
          {
            return ketIcon = Container(
              color: Colors.deepOrangeAccent,
              height: 25.0,
              // height of the button
              width: 25.0,
              // width of the button
              child: Center(
                  child: Text('C', style: TextStyle(color: Colors.white))),
            );
          }
          break;
        case 'i':
          {
            return ketIcon = Container(
              color: Colors.purpleAccent,
              height: 25.0,
              // height of the button
              width: 25.0,
              // width of the button
              child: Center(
                  child: Text('I', style: TextStyle(color: Colors.white))),
            );
          }
          break;
        case 't':
          {
            return ketIcon = Container(
              color: Colors.indigo,
              height: 25.0,
              // height of the button
              width: 25.0,
              // width of the button
              child: Center(
                  child: Text('T', style: TextStyle(color: Colors.white))),
            );
          }
          break;
        case 'g':
          {
            return ketIcon = Container(
              color: Colors.pinkAccent,
              height: 25.0,
              // height of the button
              width: 25.0,
              // width of the button
              child: Center(
                  child: Text('G', style: TextStyle(color: Colors.white))),
            );
          }
          break;
        default:
          {
            return ketIcon = Container(
              color: Colors.grey,
              height: 25.0,
              // height of the button
              width: 25.0,
              // width of the button
              child: Center(
                  child: Text('M', style: TextStyle(color: Colors.white))),
            );
          }
      }
    }

    var width = MediaQuery.of(context).size.width;
    ctx = context;

    tooltip = SuperTooltip(
        popupDirection: TooltipDirection.down,
        arrowTipDistance: 10.0,
        maxHeight: 300,
        borderColor: Colors.white,
        content: new Material(
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(string.text.lbl_keterangan_absen + " :\n"),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: ClipOval(
                          child: Container(
                            color: Colors.grey,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('M',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(child: Text(" : " + string.text.lbl_mobile)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: ClipOval(
                          child: Container(
                            color: Colors.greenAccent,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('F',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(" : " + string.text.lbl_fingerprint)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: ClipOval(
                          child: Container(
                            color: Colors.lightBlueAccent,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('W',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(" : " + string.text.lbl_web)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: ClipOval(
                          child: Container(
                            color: Colors.green,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('D',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(" : " + string.text.lbl_sppd)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: ClipOval(
                          child: Container(
                            color: Colors.deepPurple,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('S',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(" : " + string.text.lbl_sakit)),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text("\n"),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: ClipOval(
                          child: Container(
                            color: Colors.deepOrangeAccent,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('C',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(" : " + string.text.lbl_cuti)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: ClipOval(
                          child: Container(
                            color: Colors.purpleAccent,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('I',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(" : " + string.text.lbl_izin)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: ClipOval(
                          child: Container(
                            color: Colors.indigo,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('T',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                              " : " + string.text.lbl_pengganti_hari_libur)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: ClipOval(
                          child: Container(
                            color: Colors.pinkAccent,
                            height: 25.0, // height of the button
                            width: 25.0, // width of the button
                            child: Center(
                                child: Text('G',
                                    style: TextStyle(color: Colors.white))),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 5),
                          child:
                              Text(" : " + string.text.lbl_penugasan_di_luar)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));

    return new WillPopScope(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: theme.Colors.backgroundHumanCapital,
        title: Text(string.text.page_lihat_kantor,
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
      body: new SafeArea(
        child: new Column(children: [
          Card(
            margin: EdgeInsets.fromLTRB(4.0, 8.0, 4.0, 0.0),
            child: Container(
              padding:
              EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 46.0,
                    width: 46.0,
                    margin: EdgeInsets.only(right: 16.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                        image: new DecorationImage(
                            fit: BoxFit.cover,
                            image: new NetworkImage(
                                "https://images.unsplash.com/photo-1456327102063-fb5054efe647?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1350&q=80"))),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '21190042',
                          style: TextStyle(
                              color: theme
                                  .Colors.colorTextBlackReportAbsenAtasan,
                              fontWeight: FontWeight.normal,
                              fontSize: 12.4),
                        ),
                        Text(
                          'ASTO ARIANTO MIWANDA',
                          style: TextStyle(
                              color: theme
                                  .Colors.colorTextBlackReportAbsenAtasan,
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
                              vertical: 5.0, horizontal: 15.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(26.0)),
                          child: Text('Hadir', style: TextStyle(color: Colors.white, fontSize: 13.0),),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: width,
              margin: EdgeInsets.only(top: 8.0),
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: StickyHeader(
                      header: new Container(
                        height: 50.0,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        margin: EdgeInsets.only(bottom: 16.0),
                        color: Colors.lightBlueAccent,
                        alignment: Alignment.centerLeft,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                      child: new Text(string.text.lbl_nomor,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15)))),
                              Expanded(
                                  child: new Text(string.text.lbl_tanggal,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15))),
                              Expanded(
                                  child: new Text(string.text.lbl_jam_masuk,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15))),
                              Expanded(
                                child: Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: new Text(string.text.lbl_jam_pulang,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15))),
                              ),
                              Expanded(
                                child: Container(
                                    child: GestureDetector(
                                  onTap: onTap,
                                  child: Container(
                                    key: _containerKey,
                                    padding: EdgeInsets.only(left: 30),
                                    child: new Text(string.text.lbl_ket,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15)),
                                  ),
                                )),
                              ),
                            ]),
                      ),
                      content: Table(
                        children: List<int>.generate(
                                lengthReportAbsen, (index) => index)
                            .map((item) => TableRow(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 16),
                                      child: Text((item + 1).toString()),
                                    ),
                                    Text(
                                      tanggalAbsen[item],
                                      style: TextStyle(fontSize: 12.0),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(jamMasukAbsen[item]),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 18),
                                      child: Text(jamPulangAbsen[item]),
                                    ),
                                    Center(
                                      child: Container(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: GestureDetector(
                                            child: ClipOval(
                                              child: ketWidgetAbsen(
                                                  ketAbsen[item]),
                                            ),
                                          )),
                                    )
                                  ],
                                ))
                            .toList(),
                      )),
                ),
              ),
            ),
          ),
        ]),
      ),
    ));
    //);
  }

  makeGetRequest() async {
    var data_absensi;
    pr.show();
    final uri = api.Api.report_absen + "$nik/";
    print(uri);
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Response response = await get(uri, headers: headers);

    var data = jsonDecode(response.body);
    data_absensi = (data["data"] as List)
        .map((data) => new dataReport.fromJson(data))
        .toList();

    foreachHasil(data_absensi);
  }

  void foreachHasil(List<dataReport> data_absensi) {
    pr.hide();
    setState(() {
      lengthReportAbsen = data_absensi.length;
    });

    if (data_absensi.length < 1) {
      Toast.show("Data anda Kosong", ctx,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    } else {
      tanggalAbsen.clear();
      jamMasukAbsen.clear();
      jamPulangAbsen.clear();
      ketAbsen.clear();
    }

    for (var ini = 0; ini < data_absensi.length; ini++) {
      //TODO setstate
      setState(() {
        tanggalAbsen.add(data_absensi[ini].tanggal);
        jamMasukAbsen.add(data_absensi[ini].jam_masuk);
        jamPulangAbsen.add(data_absensi[ini].jam_pulang);
        ketAbsen.add(data_absensi[ini].keterangan);
      });
    }
  }
}

class dataReport {
  String tanggal;
  String jam_masuk;
  String jam_pulang;
  String keterangan;

  dataReport({this.tanggal, this.jam_masuk, this.jam_pulang, this.keterangan});

  factory dataReport.fromJson(Map<String, dynamic> parsedJson) {
    return dataReport(
        tanggal: parsedJson['present_date'].toString(),
        jam_masuk: parsedJson['in_dtm'].toString(),
        jam_pulang: parsedJson['out_dtm'].toString(),
        keterangan: parsedJson['keterangan'].toString());
  }
}
