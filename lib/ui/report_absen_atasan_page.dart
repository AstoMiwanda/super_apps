import 'package:flutter/material.dart';
import 'package:super_apps/style/theme.dart' as theme;
import 'package:super_apps/style/string.dart' as string;

class ReportAbsenAtasan extends StatefulWidget {
  @override
  _ReportAbsenAtasanState createState() => _ReportAbsenAtasanState();
}

class _ReportAbsenAtasanState extends State<ReportAbsenAtasan> {
  @override
  Widget build(BuildContext context) {
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
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              GestureDetector(
                onTap: () {},
                child: Card(
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
              ),
              GestureDetector(
                onTap: () {},
                child: Card(
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 16.0),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.0, horizontal: 15.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(26.0)),
                                  child: Text('Belum Hadir', style: TextStyle(color: Colors.white, fontSize: 12.0),),
                                ),
                              ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ]),
          )
        ],
      ),
    );
  }
}
