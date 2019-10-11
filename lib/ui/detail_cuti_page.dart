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
    return Container();
  }

  Widget cardProfile = Card(
    margin: EdgeInsets.all(8.0),
    child: Column(
      children: <Widget>[
        Container(
          padding:
          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.Colors.backgroundAbsen),
                width: 46.0,
                height: 46.0,
                child: SvgPicture.asset(string.text.icon_profile_cuti,
                    placeholderBuilder: (context) => Icon(Icons.error)),
              ),
              Container(
                margin: EdgeInsets.only(left: 16.0),
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
              /*
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              child: SvgPicture.asset(string.text.icon_profile_cuti,
                                  placeholderBuilder: (context) => Icon(Icons.error)),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Text('8'),
                                ),
                                Container(
                                  child: Text('saldo cuti'),
                                )
                              ],
                            )
                          ],
                        ),
                      )

                       */
            ],
          ),
        ),
        Container(
          height: 1.0,
          margin: EdgeInsets.symmetric(horizontal: 1.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft:  const  Radius.circular(2.0),
                bottomRight: const  Radius.circular(2.0)),
            color: theme.Colors.backgroundAbsen,
          ),
        ),
      ],
    ),
  );
}
