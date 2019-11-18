import 'package:flutter/material.dart';
import 'package:super_apps/style/theme.dart' as theme;
import 'package:super_apps/style/string.dart' as string;
import 'package:flutter_svg/flutter_svg.dart';

class DetailCutiPage extends StatefulWidget {
  @override
  _DetailCutiPageState createState() => _DetailCutiPageState();
}

class _DetailCutiPageState extends State<DetailCutiPage> {
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
        primary: false,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                cardProfile,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardProfile = Card(
    margin: EdgeInsets.all(8.0),
    child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'ASTO ARIANTO MIWANDA',
                        style: TextStyle(
                          color: theme.Colors.textBlackDetailCuti,
                          fontSize: 14.0,
                        ),
                      ),
                      Text(
                        '21190042',
                        style: TextStyle(
                            color: theme.Colors.textGrayDetailCuti,
                            fontSize: 12.0,
                            height: 1.4),
                      )
                    ],
                  ),
                ),
                flex: 3,
              ),
              Expanded(
                child: Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        child: Image.asset(string.text.icon_tiket_cuti),
                      ),
                    ],
                  ),
                ),
                flex: 1,
              ),

            ],
          ),
        ),
        Container(
          height: 1.0,
          margin: EdgeInsets.symmetric(horizontal: 1.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: const Radius.circular(2.0),
                bottomRight: const Radius.circular(2.0)),
            color: theme.Colors.backgroundAbsen,
          ),
        ),
      ],
    ),
  );
  Widget infoCuti = Card();
}
