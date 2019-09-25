import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:super_apps/ui/tabs/keepalive_widget.dart';
import 'package:super_apps/ui/pop_notif_page.dart';
import 'package:super_apps/style/string.dart' as string;
import 'package:super_apps/style/theme.dart' as theme;

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPage createState() => _NotificationPage();
}

class _NotificationPage extends State<NotificationPage> {
  var numNotification = 1;
  var readNotification;
  var typeNotification;
  var iconNotif;

  Color bgIcon;
  Color bgNotifStatus;
  Color bgNotifLine;
  double widthDevice;

  var titleNotif = "Jangan Lupa absen !";
  var descNotif = "Potong gaji lebih sedih daripada ditinggal gebetan :D";
  var dateNotif = "16 September 2019";
  var timeNotif = "10.00";

  listNotification({readNotification}) {
    readNotification = readNotification;
    typeNotification = "remainder";

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
    }

    if (numNotification == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: bgIcon,
                  ),
                  child: Container(
                    width: 36.0,
                    height: 36.0,
                    child: SvgPicture.asset(
                        iconNotif,
                        placeholderBuilder: (context) => Icon(Icons.error)),
                  ),
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
                          mainAxisAlignment: MainAxisAlignment.center,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            dateNotif,
                            style: TextStyle(
                                fontSize: 11.0,
                                color: theme.Colors.colorTextGray_60),
                          ),
                          Text(
                            timeNotif,
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
    setState(() {
      widthDevice = MediaQuery.of(context).size.width;
    });

    return Scaffold(
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
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return listNotification(readNotification: true);
                  }
              ),
            ),
            RaisedButton(
              onPressed: () {
                return Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationPagePopUp()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
