import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:super_apps/style/theme.dart' as theme;
import 'package:super_apps/style/string.dart' as string;
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_apps/api/api.dart' as api;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_apps/ui/report_absen_atasan_page.dart';
import 'package:super_apps/ui/notification_page.dart';
import 'package:super_apps/ui/report_absen_page.dart';
import 'package:super_apps/ui/lihat_kantor_page.dart';
import 'package:toast/toast.dart';

String nik = '';
List imgList = [];
String notif = '';
BuildContext ctx;
String message;

int countNotif = 0;
int levelUser = 0;

class MainMenu extends StatefulWidget {
  MainMenu({Key key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  var data;

  @override
  void initState() {
    super.initState();
    getNik();
  }

  getNik() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nik = (prefs.getString('username') ?? '');
      getDataMenu(context);
      getCountNotif(context);
      getLevel(context);
    });
  }

  double widthDevice;
  List<List<String>> listMenu = [
    [
      string.Icons.icon_human_capital,
      string.Text.menu_human_capital,
      '3',
      'unlocked'
    ],
    [
      string.Icons.icon_document_management,
      string.Text.menu_document_management,
      '2',
      'locked'
    ],
    [string.Icons.icon_project, string.Text.menu_project, '1', 'locked'],
    [
      string.Icons.icon_supply_chain,
      string.Text.menu_supply_chain,
      '5',
      'locked'
    ],
    [string.Icons.icon_finance, string.Text.menu_finance, '2', 'locked'],
    [string.Icons.icon_oss, string.Text.menu_oss, '8', 'locked'],
    [string.Icons.icon_tools, string.Text.menu_tools, '10', 'locked'],
    [string.Icons.icon_video, string.Text.menu_video, '10', 'locked'],
    [string.Icons.icon_link, string.Text.menu_link, '6', 'locked'],
  ];

  List<List<String>> listMenuHumanCapital = [
    [
      string.Icons.icon_report_absent,
      string.Text.page_report_absen,
      '3',
      'unlocked'
    ],
    [
      string.Icons.icon_office_location,
      string.Text.page_lihat_kantor,
      '2',
      'unlocked'
    ],
    [
      string.Icons.icon_report_absent_supervisor,
      string.Text.page_report_absen_atasan,
      '3',
      'unlocked'
    ]
  ];

  mainMenuHeaderLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 46.0,
            child: Image.asset(string.Icons.uri_logo_ta_putih),
          ),
          GestureDetector(
            onTap: () {
              return Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
            child: Stack(
              alignment: Alignment(1, -1),
              children: <Widget>[
                Icon(
                  Icons.notifications_active,
                  size: 28,
                  color: Colors.white,
                ),
                countNotif != 0
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.5, horizontal: 3.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          color: Colors.red,
                        ),
                        child: Text(
                          (countNotif <= 999) ? countNotif.toString() : '999+',
                          style: TextStyle(fontSize: 10.0, color: Colors.white),
                        ),
                      )
                    : Container(),
              ],
            ),
          )
        ],
      ),
    );
  }

  mainMenuHeader() {
    return Container(
      color: theme.Colors.backgroundAbsen,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[mainMenuHeaderLogo()],
        ),
      ),
    );
  }

  mainMenuItem({String icon, String title, String status, int numApp}) {
    Widget itemTitle;
    Widget itemSubTitle;
    Widget lockedApps = Container();
    Color cardColor, iconColor;
    cardColor = theme.Colors.backgroundIconMainMenu;
    iconColor = theme.Colors.iconMainMenu;

    if (status == 'locked') {
      lockedApps = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 64.0,
            padding: EdgeInsets.all(12.0),
            child: SvgPicture.asset(string.Icons.uri_locked_apps,
                placeholderBuilder: (context) => Icon(Icons.error)),
          ),
        ],
      );
    }

    if (numApp == 1) {
      itemSubTitle = Container(
        padding: const EdgeInsets.only(top: 1.5),
        child: Text(numApp.toString() + ' Application',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.0, color: Colors.grey[600])),
      );
    } else if (title == 'Video') {
      itemSubTitle = Container(
        padding: const EdgeInsets.only(top: 1.5),
        child: Text(numApp.toString() + ' Video',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.0, color: Colors.grey[600])),
      );
    } else {
      itemSubTitle = Container(
        padding: const EdgeInsets.only(top: 1.5),
        child: Text(numApp.toString() + ' Applications',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.0, color: Colors.grey[600])),
      );
    }

    itemTitle = Container(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: iconColor,
        ),
        textAlign: TextAlign.center,
      ),
    );

    return Column(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(color: cardColor, shape: BoxShape.circle),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 64.0,
                      padding: EdgeInsets.all(16.0),
                      child: SvgPicture.asset(icon,
                          placeholderBuilder: (context) => Icon(Icons.error)),
                    ),
                  ],
                ),
                lockedApps,
              ],
            )),
        itemTitle
      ],
    );
  }

  mainMenuMore() {
    return Column(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
                color: theme.Colors.backgroundIconMainMenu,
                shape: BoxShape.circle),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 64.0,
                      padding: EdgeInsets.all(16.0),
                      child: SvgPicture.asset(string.Icons.uri_more_apps,
                          placeholderBuilder: (context) => Icon(Icons.error)),
                    ),
                  ],
                ),
              ],
            )),
        Container(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            string.Text.lbl_more,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: theme.Colors.iconMainMenu,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  _moreMainMenuItem(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0))),
        builder: (BuildContext bc) {
          return CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(
                      height: 32.0,
                    )
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 8.0,
                    maxCrossAxisExtent: 90.0,
                    childAspectRatio: .7,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.center,
                        color: theme.Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            Navigator.pop(context);
                            switch (listMenu[index][1]) {
                              case 'Human Capital':
                                return _subMainMenuItem(context);
                                break;
                              default:
                                return null;
                                break;
                            }
                          },
                          child: mainMenuItem(
                              icon: listMenu[index][0],
                              title: listMenu[index][1],
                              numApp: int.parse(listMenu[index][2]),
                              status: listMenu[index][3]),
                        ),
                      );
                    },
                    childCount: listMenu == null ? 0 : listMenu.length,
                  ),
                ),
              )
            ],
          );
        });
  }

  _subMainMenuItem(context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0))),
        builder: (BuildContext bc) {
          return CustomScrollView(
            primary: false,
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    SizedBox(
                      height: 16.0,
                    ),
                    Container(
                      margin: EdgeInsets.all(16.0),
                      child: Text(
                        string.Text.lbl_absent,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: theme.Colors.colorTextBlackMainMenu,
                            fontSize: 16.0),
                      ),
                    )
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 8.0,
                    maxCrossAxisExtent: 90.0,
                    childAspectRatio: .7,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.center,
                        color: theme.Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.blue.withAlpha(30),
                          onTap: () {
                            Navigator.pop(context);
                            if (listMenuHumanCapital[index][1] ==
                                string.Text.page_report_absen) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReportPage()),
                              );
                            } else if (listMenuHumanCapital[index][1] ==
                                string.Text.page_report_absen_atasan) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReportAbsenAtasan()),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => lihat_kantor_page()),
                              );
                            }
                          },
                          child: ((levelUser >= 5) && (index == 2))
                              ? Container()
                              : mainMenuItem(
                                  icon: listMenuHumanCapital[index][0],
                                  title: listMenuHumanCapital[index][1],
                                  numApp:
                                      int.parse(listMenuHumanCapital[index][2]),
                                  status: listMenuHumanCapital[index][3]),
                        ),
                      );
                    },
                    childCount: listMenuHumanCapital == null
                        ? 0
                        : listMenuHumanCapital.length,
                  ),
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    widthDevice = MediaQuery.of(context).size.width;
    ctx = context;

    Widget mainMenuSlideShow = Container(
      width: widthDevice,
      height: widthDevice * .5,
      child: Carousel(
        images: imgList.map((imgUrl) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                ),
                child: Image.network(
                  imgUrl,
                  fit: BoxFit.fill,
                ),
              );
            },
          );
        }).toList(),
        autoplay: true,
        autoplayDuration: Duration(seconds: 4),
        dotBgColor: theme.Colors.transparent,
        dotColor: Colors.white,
        dotIncreasedColor: Colors.cyan,
        dotSize: 4.0,
      ),
    );
    Widget mainMenuBrokenImage = Container(
      color: Colors.grey[400],
      height: widthDevice * .4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.broken_image,
            color: Colors.white,
          ),
        ],
      ),
    );

    return Scaffold(
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                mainMenuHeader(),
                imgList.length != 0 ? mainMenuSlideShow : mainMenuBrokenImage
              ],
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 16.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 8.0,
                maxCrossAxisExtent: 90.0,
                childAspectRatio: .7,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: theme.Colors.transparent,
                    child: InkWell(
                      splashColor: theme.Colors.transparent,
                      highlightColor: theme.Colors.transparent,
                      onTap: () {
                        switch (listMenu[index][1]) {
                          case 'Human Capital':
                            return _subMainMenuItem(context);
                            break;
                          default:
                            if (index == 7) {
                              return _moreMainMenuItem(context);
                            }
                            break;
                        }
                      },
                      child: index < 7
                          ? mainMenuItem(
                              icon: listMenu[index][0],
                              title: listMenu[index][1],
                              numApp: int.parse(listMenu[index][2]),
                              status: listMenu[index][3])
                          : mainMenuMore(),
                    ),
                  );
                },
                childCount: listMenu == null
                    ? 0
                    : listMenu.length > 7 ? 8 : listMenu.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, String str) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert"),
          content: new Text(str),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> getDataMenu(BuildContext context) async {
    var url_api = api.Api.menu;
    try {
      var response = await http.get(
          Uri.encodeFull("${url_api}${nik}/${api.Api.versi}"),
          headers: {"Accept": "application/json"});
      var data = jsonDecode(response.body);
      var data_profile = (data["data"] as List)
          .map((data) => new dataProfile.fromJson(data))
          .toList();
      foreachHasil(data_profile, context);

    } catch (e) {
      message = string.Message.msg_server_err;
      Toast.show(message, ctx,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

    }
    
  }

  Future<String> getCountNotif(BuildContext context) async {
    final uri = api.Api.notification + "$nik/0";
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    try {
      var response = await http.get(Uri.encodeFull("$uri"), headers: headers);
      var data = jsonDecode(response.body);
      setState(() {
        countNotif = data["data"];
      });  

    } catch (e) {
      message = string.Message.msg_server_err;
      Toast.show(message, ctx,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

    }
    
  }

  Future<String> getLevel(BuildContext context) async {
    final uri = api.Api.level_user + "$nik";
    final headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    try {
      var response = await http.get(Uri.encodeFull("$uri"), headers: headers);
      var data = jsonDecode(response.body);
      setState(() {
        levelUser = data['data'];
      });

    } catch (e) {
      message = string.Message.msg_server_err;
      Toast.show(message, ctx,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

    }
    
  }

  void foreachHasil(List<dataProfile> data_profile, BuildContext ctx) {
    int is_notif = 0;
    int versi = 0;
    for (int ini = 0; ini < data_profile.length; ini++) {
      setState(() {
        notif = data_profile[ini].notif;
        imgList = data_profile[ini].foto;
        is_notif = data_profile[ini].is_notif;
        versi = data_profile[ini].versi;
      });
    }

    if (versi > int.parse(api.Api.versi)) {
      _showDialog(ctx, "Perbarui Aplikasi Anda melalui portal / playstore");
    }
    if (is_notif == 1) {
      _showDialog(ctx, notif);
    }
  }
}

class dataProfile {
  List foto;
  String notif;
  int is_notif;
  int versi;

  dataProfile({this.foto, this.notif, this.is_notif, this.versi});

  factory dataProfile.fromJson(Map<String, dynamic> parsedJson) {
    return dataProfile(
      foto: parsedJson['image_foto'],
      is_notif: parsedJson['is_notif'],
      versi: parsedJson['versi'],
      notif: parsedJson['notif'].toString(),
    );
  }
}
