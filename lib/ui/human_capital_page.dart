import 'package:flutter/material.dart';
import 'package:super_apps/style/theme.dart' as theme;
import 'package:super_apps/style/string.dart' as string;
import 'package:super_apps/ui/absen_page.dart';
import 'package:super_apps/ui/lihat_kantor_page.dart';
import 'package:super_apps/ui/report_absen_page.dart';

class HumanCapital extends StatefulWidget {
  HumanCapital({Key key}) : super(key: key);
  _HumanCapital createState() => new _HumanCapital();
}

class _HumanCapital extends State<HumanCapital> {
  double widthDevice;
  List<List<String>> listMenu = [
    [string.Text.page_absensi, string.Images.uri_human_capital_absen],
    [
      string.Text.page_report_absen,
      string.Images.uri_human_capital_report_absen
    ],
    [
      string.Text.page_lihat_kantor,
      string.Images.uri_human_capital_lokasi_kantor
    ],
  ];

  humanCapitalList({String icon, String title}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 32.0, bottom: 16.0),
          width: widthDevice - (widthDevice / 4 + 32.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          child: ClipRRect(
            borderRadius: new BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0)),
            child: Image.asset(
              icon,
              width: widthDevice / 4,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    widthDevice = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(string.Text.menu_human_capital,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: theme.Colors.backgroundAbsen,
      ),
      body: Container(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                      color: theme.Colors.backgroundHumanCapital,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: InkWell(
                        splashColor: Colors.lightBlue,
                        onTap: () {
                          if (listMenu[index][0] == 'Absen') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Absen()),
                            );
                          } else if (listMenu[index][0] == 'Report Absen') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReportPage()),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => lihat_kantor_page()),
                            );
                          }
                        },
                        child: humanCapitalList(
                          icon: listMenu[index][1],
                          title: listMenu[index][0],
                        ),
                      ),
                    ),
                  );
                },
                childCount: listMenu == null ? 0 : listMenu.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
