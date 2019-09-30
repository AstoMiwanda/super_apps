import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_apps/style/string.dart' as string;
import 'package:super_apps/style/theme.dart' as theme;

double widthDevice;
double heightDevice;
double heightAppBar;
int numNotification;
bool readNotification;

Color bgIcon;
Color bgNotifStatus;
Color bgNotifLine;

String typeNotification;
String iconNotif;
String titleNotif;
String descNotif;
String dateNotif;
String timeNotif;

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPage createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {
  listNotification({bool readNotification, String typeNotification}) {
    if (readNotification) {
      bgNotifStatus = Colors.white;
      bgNotifLine = theme.Colors.backgroundNotificationUnread;
    } else {
      bgNotifStatus = theme.Colors.backgroundNotificationUnread;
      bgNotifLine = Colors.white;
    }

    print(typeNotification);
    if (typeNotification == "remainder") {
      iconNotif = string.text.uri_remainder_notification;
      bgIcon = theme.Colors.backgroundRemainderNotification;
    } else if (typeNotification == "approval") {
      iconNotif = string.text.uri_approval_notification;
      bgIcon = theme.Colors.backgroundApprovalNotification;
    } else if (typeNotification == "absen") {
      iconNotif = string.text.uri_absen_notification;
      bgIcon = theme.Colors.backgroundAbsenNotification;
    } else {
      iconNotif = '';
      bgIcon = Colors.red;
    }

    if (numNotification == 0) {
      return Container(
        height: heightDevice - (heightAppBar + 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 147.0,
              margin: EdgeInsets.only(bottom: 16.0),
              child: SvgPicture.asset(string.text.uri_empty_notification,
                  placeholderBuilder: (context) => Icon(Icons.error)),
            ),
            Text(
              string.text.lbl_tidak_ada_notification,
              style: TextStyle(color: theme.Colors.colorTextGray_60),
            )
          ],
        ),
      );
    } else {
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            color: bgNotifStatus,
            child: Row(
              children: <Widget>[
                Container(
                  width: 60.0,
                  height: 60.0,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: bgIcon,
                  ),
                  child: SvgPicture.asset(iconNotif,
                      placeholderBuilder: (context) => Icon(Icons.error)),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16.0),
                  width: widthDevice - (108.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              titleNotif,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: theme.Colors.colorTextGray,
                              ),
                            ),
                            Text(
                              descNotif,
                              style: TextStyle(
                                  color: theme.Colors.colorTextGray,
                                  fontSize: 12.0,
                                  height: 1.4),
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            dateNotif+'\n'+timeNotif,
                            style: TextStyle(
                                fontSize: 11.0,
                                color: theme.Colors.colorTextGray_60),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 2.0,
            color: bgNotifLine,
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
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
    );

    setState(() {
      widthDevice = MediaQuery.of(context).size.width;
      heightDevice = MediaQuery.of(context).size.height;
      heightAppBar = appBar.preferredSize.height;
      numNotification = 2;
      titleNotif = "Jangan Lupa absen !";
      descNotif = "Potong gaji lebih sedih daripada ditinggal gebetan :D";
      dateNotif = "16 September 2019";
      timeNotif = "10.00";
      readNotification = true;
      typeNotification = "approval";
    });

    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: ListView.builder(
            itemCount: numNotification == 0 ? 1 : numNotification,
            itemBuilder: (context, index) {
              return listNotification(readNotification: readNotification, typeNotification: typeNotification);
            }),
      ),
    );
  }
}
