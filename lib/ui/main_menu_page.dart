import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:super_apps/style/theme.dart' as theme;
import 'package:super_apps/style/string.dart' as string;
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_apps/api/api.dart' as api;
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:super_apps/ui/human_capital_page.dart';

String nik = '';
List imgList = [];
String notif = '';

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
    setState((){
      nik = (prefs.getString('username') ?? '');
      getDataMenu();
    });
  }

  Future<String> getDataMenu() async {
    var url_api = api.Api.menu;
    var response = await http.get(Uri.encodeFull("${url_api}${nik}/${api.Api.versi}"),
        headers: {"Accept": "application/json"});
    var data = jsonDecode(response.body);
    var data_profile = (data["data"] as List)
        .map((data) => new dataProfile.fromJson(data))
        .toList();
    foreachHasil(data_profile);
  }

  double widthDevice;
  List<List<String>> listMenu = [
    ['assets/icon/main_menu_page/human_capital.svg', 'Human Capital', '3', 'unlocked'],
    [
      'assets/icon/main_menu_page/document_management_abu.svg',
      'Document Management',
      '2',
      'locked'
    ],
    ['assets/icon/main_menu_page/project_abu.svg', 'Project', '1', 'locked'],
    ['assets/icon/main_menu_page/supply_chain_abu.svg', 'Supply Chain', '5', 'locked'],
    ['assets/icon/main_menu_page/finance_abu.svg', 'FINANCE', '2', 'locked'],
    ['assets/icon/main_menu_page/oss_abu.svg', 'OSS', '8', 'locked'],
    ['assets/icon/main_menu_page/tools_abu.svg', 'Tools', '10', 'locked'],
    ['assets/icon/main_menu_page/video_abu.svg', 'Video', '10', 'locked'],
    ['assets/icon/main_menu_page/LINK_abu.svg', 'Link', '6', 'locked'],
  ];

  mainMenuHeaderLogo() {
    return Container(
      height: 54.0,
      child: Image.asset(string.text.uri_logo_ta_putih),
    );
  }

  mainMenuHeader() {
    return Container(
      padding: EdgeInsets.only(top: 36.0, bottom: 16.0),
      color: theme.Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[mainMenuHeaderLogo()],
      ),
    );
  }

  mainMenuItem({String icon, String title, String status, int numApp}) {
    Widget itemSubTitle;
    Widget lockedApps = Container();
    Color cardColor, iconColor;
    if(status == 'locked'){
      cardColor = Colors.grey[350];
      iconColor = Colors.grey[600];
      /*
      lockedApps = Container(
        alignment: Alignment(0,0),
        child: Image.asset(string.text.uri_absen_masuk),
      );

       */
    } else {
      cardColor = Colors.white;
      iconColor = theme.Colors.iconMainMenu;
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

    return Container(
          decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(8.0)
          ),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 46.0,
                    child: SvgPicture.asset(icon,
                        placeholderBuilder: (context) => Icon(Icons.error)),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: iconColor,
                      ),
                    ),
                  ),
                  itemSubTitle,
                ],
              ),
              lockedApps,
            ],
          )
    );
  }

  @override
  Widget build(BuildContext context) {
    widthDevice = MediaQuery.of(context).size.width;

    Widget mainMenuSlideShow = Container(
      height: widthDevice * .4,
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
      backgroundColor: theme.Colors.backgroundAbsen,
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
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                crossAxisCount: 2,
                childAspectRatio: 1.6,
              ),
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: InkWell(
                        splashColor: Colors.blue.withAlpha(30),
                        onTap: () {
                          switch (listMenu[index][1]) {
                            case 'Human Capital':
                              return Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HumanCapital()),
                              );
                              break;
                            default:
                              return Future.delayed(
                                  Duration(milliseconds: 200))
                                  .then((_) {
                                final snackBar = SnackBar(
                                    content: Text(string.text.lbl_locked_apps),
                                    action: SnackBarAction(
                                      label: 'OK',
                                      onPressed: () {
                                        // Some code to undo the change.
                                      },
                                    ));
                                Scaffold.of(context)
                                    .showSnackBar(snackBar);
                              });
                              break;
                          }
                        },
                        child: mainMenuItem(
                          icon: listMenu[index][0],
                          title: listMenu[index][1],
                          numApp: int.parse(listMenu[index][2]),
                          status: listMenu[index][3]
                        ),
                      ),
                    ),
                  );
                },
                childCount: listMenu == null ? 0 : listMenu.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  void foreachHasil(List<dataProfile> data_profile) {
    for (int ini = 0; ini < data_profile.length; ini++) {
      setState(() {
        notif = data_profile[ini].notif;
        imgList = data_profile[ini].foto;
        print(imgList);
      });
    }
  }
}

class dataProfile {
  List foto;
  String notif;

  dataProfile({this.foto, this.notif});

  factory dataProfile.fromJson(Map<String, dynamic> parsedJson) {
    return dataProfile(
      foto: parsedJson['image_foto'],
      notif: parsedJson['notif'].toString(),
    );
  }
}
