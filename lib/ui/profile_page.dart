import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:super_apps/api/api.dart' as api;
import 'package:super_apps/style/string.dart' as string;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_apps/ui/login_page.dart';

BuildContext ctx;
ProgressDialog pr;

String nik = '';
String nama = '';
String jabatan = '';
String jenis_kelamin = '';
String tempat_tanggal_lahir = '';
String agama = '';
String status_kerja = '';
String lokasi_kerja = '';
String email = '';
String atasan = '';
String foto = '';
String username = '';

double widthDevice;
double heightDevice;
double heightProfileImg;
double widthIcon;
double widthDataProfile;

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  _Profile createState() => new _Profile();
}

class _Profile extends State<Profile> {
  imgProfile() {
    if (foto == '') {
      return Container(
        margin: EdgeInsets.only(right: 8.0),
        width: heightProfileImg,
        height: heightProfileImg,
        alignment: Alignment(0, 0),
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.white70),
        child: Icon(
          Icons.person,
          size: 86.0,
          color: Colors.grey,
        ),
      );
    } else {
      return Container(
          margin: EdgeInsets.only(right: 8.0),
          width: heightProfileImg,
          height: heightProfileImg,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white70,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  alignment: Alignment(0, -1),
                  image: NetworkImage(foto, scale: 1.0))));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pr = new ProgressDialog(context,type: ProgressDialogType.Normal);
    getNik();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    ctx = context;
    setState(() {
      widthDevice = MediaQuery.of(context).size.width;
      heightDevice = MediaQuery.of(context).size.height;
      heightProfileImg = widthDevice * .4;
      widthIcon = 36.0;
      widthDataProfile = 68.0;
    });

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(string.text.uri_bg_profile),
            fit: BoxFit.fill,
          ),
        ),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  padding: EdgeInsets.only(left: 8.0, top: 64.0, right: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      imgProfile(),
                      Container(
                        height: heightProfileImg,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              child: InkWell(
                                onTap: () async {
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  prefs.setString('username', '');
                                  prefs.commit();
                                  pr.hide();
                                  Navigator.pushAndRemoveUntil(
                                    ctx,
                                    MaterialPageRoute(builder: (context) => new Login()),
                                    ModalRoute.withName("/Login")
                                  );
                                },
                                child: SvgPicture.asset(
                                  string.text.uri_logout,
                                  placeholderBuilder: (context) =>
                                      Icon(Icons.error),
                                  width: 32.0,
                                ),
                              ),
                            ),
                            Container(
                              width:
                                  widthDevice - (heightProfileImg + 16.0 + 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    nik,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 2.0),
                                    child: Text(
                                      nama,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8.0),
                                    child: Text(
                                      jabatan,
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: heightDevice - (heightProfileImg + 64.0)),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(
                        32.0, heightDevice * .12, 32.0, 32.0),
                    margin: EdgeInsets.only(top: 8.0, right: 16.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(string.text.uri_bg_detail_profile),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                child: SvgPicture.asset(
                                  string.text.uri_gender,
                                  semanticsLabel: string.text.lbl_jenis_kelamin,
                                  placeholderBuilder: (context) =>
                                      Icon(Icons.error),
                                  width: widthIcon,
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Container(
                                width: widthDevice -
                                    (16.0 + 32.0 + 16.0 + widthDataProfile),
                                child: Text(
                                  jenis_kelamin,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                child: SvgPicture.asset(
                                  string.text.uri_brithday,
                                  semanticsLabel: string.text.lbl_hari_lahir,
                                  placeholderBuilder: (context) =>
                                      Icon(Icons.error),
                                  width: widthIcon,
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Container(
                                width: widthDevice -
                                    (16.0 + 32.0 + 16.0 + widthDataProfile),
                                child: Text(
                                  tempat_tanggal_lahir,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                child: SvgPicture.asset(
                                  string.text.uri_religion,
                                  semanticsLabel: string.text.lbl_agama,
                                  placeholderBuilder: (context) =>
                                      Icon(Icons.error),
                                  width: widthIcon,
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Container(
                                width: widthDevice -
                                    (16.0 + 32.0 + 16.0 + widthDataProfile),
                                child: Text(
                                  agama,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                child: SvgPicture.asset(
                                  string.text.uri_status_merried,
                                  semanticsLabel:
                                      string.text.lbl_status_menikah,
                                  placeholderBuilder: (context) =>
                                      Icon(Icons.error),
                                  width: widthIcon,
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Container(
                                width: widthDevice -
                                    (16.0 + 32.0 + 16.0 + widthDataProfile),
                                child: Text(
                                  status_kerja,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                child: SvgPicture.asset(
                                  string.text.uri_office,
                                  semanticsLabel: string.text.lbl_kantor,
                                  placeholderBuilder: (context) =>
                                      Icon(Icons.error),
                                  width: widthIcon,
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Container(
                                width: widthDevice -
                                    (16.0 + 32.0 + 16.0 + widthDataProfile),
                                child: Text(
                                  lokasi_kerja,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                child: SvgPicture.asset(
                                  string.text.uri_email,
                                  semanticsLabel: string.text.lbl_email,
                                  placeholderBuilder: (context) =>
                                      Icon(Icons.error),
                                  width: widthIcon,
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Container(
                                width: widthDevice -
                                    (16.0 + 32.0 + 16.0 + widthDataProfile),
                                child: Text(
                                  email,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 16.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                child: SvgPicture.asset(
                                  string.text.uri_team,
                                  placeholderBuilder: (context) =>
                                      Icon(Icons.error),
                                  width: widthIcon,
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Container(
                                width: widthDevice -
                                    (16.0 + 32.0 + 16.0 + widthDataProfile),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      atasan,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ]),
            )
          ],
        ),
      ),
    );
  }

  Future getNik() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = (prefs.getString('username') ?? '');
      makeGetRequest();
    });
  }

  void foreachHasil(List<dataProfile> data_profile) {
    for (var ini = 0; ini < data_profile.length; ini++) {
      //TODO setstate
      setState(() {
        // provide data astro
        nik = data_profile[ini].nik;
        nama = data_profile[ini].nama;
        jabatan = data_profile[ini].jabatan;
        jenis_kelamin = data_profile[ini].jenis_kelamin;
        tempat_tanggal_lahir = data_profile[ini].tempat_tanggal_lahir;
        agama = data_profile[ini].agama;
        status_kerja = data_profile[ini].status_kerja;
        lokasi_kerja = data_profile[ini].lokasi_kerja;
        email = data_profile[ini].email;
        atasan = data_profile[ini].atasan;
        foto = data_profile[ini].foto;
      });
      print(foto);
    }
  }

  makeGetRequest() async {
    var nik = username;
    final uri = api.Api.profile + "$nik/${api.Api.versi}";
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    Response response = await get(uri, headers: headers);
    var data = jsonDecode(response.body);
    var data_profile = (data["data"] as List)
        .map((data) => new dataProfile.fromJson(data))
        .toList();
    foreachHasil(data_profile);
  }
}

class dataProfile {
  String nik;
  String nama;
  String jabatan;
  String jenis_kelamin;
  String tempat_tanggal_lahir;
  String agama;
  String status_kerja;

  String lokasi_kerja;
  String email;
  String atasan;
  String foto;

  dataProfile(
      {this.nik,
      this.nama,
      this.jabatan,
      this.jenis_kelamin,
      this.tempat_tanggal_lahir,
      this.agama,
      this.status_kerja,
      this.lokasi_kerja,
      this.email,
      this.atasan,
      this.foto});

  factory dataProfile.fromJson(Map<String, dynamic> parsedJson) {
    return dataProfile(
      nik: parsedJson['nik'].toString(),
      nama: parsedJson['name'].toString(),
      jabatan: parsedJson['nama_posisi'].toString(),
      jenis_kelamin: parsedJson['jenis_kelamin'].toString(),
      tempat_tanggal_lahir: (parsedJson['kota_lahir'].toString()) +
          ", " +
          parsedJson['tgl_lahir'].toString(),
      agama: parsedJson['nama_agama'].toString(),
      status_kerja: parsedJson['nama_status_kerja'].toString(),
      lokasi_kerja: parsedJson['psa'].toString(),
      email: parsedJson['mail'].toString(),
      atasan: (parsedJson['posisi_parent_1'].toString()) +
          " \n" +
          parsedJson['name_parent_1'].toString(),
      foto: (parsedJson['foto'].toString()),
    );
  }
}
