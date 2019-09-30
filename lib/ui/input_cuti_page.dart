import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:super_apps/style/string.dart' as string;
import 'package:super_apps/style/theme.dart' as theme;

double widthDevice;
List<DropdownMenuItem<String>> _dropDownMenuItems;
String _selectedKeterangan;
DateTime _dateStart;
DateTime _dateEnd;
bool cutiLibur = false;

class InputCuti extends StatefulWidget {
  @override
  _InputCutiState createState() => _InputCutiState();
}

class _InputCutiState extends State<InputCuti> {
  List _keterangan = [
    string.text.lbl_mobile,
    string.text.lbl_fingerprint,
    string.text.lbl_web,
    string.text.lbl_izin,
    string.text.lbl_sppd,
    string.text.lbl_sakit,
    string.text.lbl_cuti,
    string.text.lbl_pengganti_hari_libur,
    string.text.lbl_penugasan_di_luar
  ];

  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String keterangan in _keterangan) {
      items.add(
          new DropdownMenuItem(value: keterangan, child: new Text(keterangan)));
    }
    return items;
  }

  Widget _dropDownHint = Text('asto azza');
  Widget _tglDariHint = Text('asto azza');

  void changedDropDownItem(String selectedCity) {
    setState(() {
      _dropDownHint = null;
      _selectedKeterangan = selectedCity;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _dropDownMenuItems = getDropDownMenuItems();
    _selectedKeterangan = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          string.text.page_input_cuti,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
                            color: theme.Colors.colorTextBlackInputCuti,
                            fontSize: 14.0,
                          ),
                        ),
                        Text(
                          '21190042',
                          style: TextStyle(
                              color: theme.Colors.colorTextGrayInputCuti,
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
          ),
          Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Jenis Cuti',
                        style: TextStyle(
                          color: theme.Colors.colorTextBlackInputCuti,
                          fontSize: 15.0,
                        ),
                      )),
                  Container(
                      height: 30.0,
                      width: widthDevice,
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      margin: EdgeInsets.only(bottom: 16.0),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 0,
                                style: BorderStyle.solid,
                                color: theme.Colors.borderInputFieldInputCuti),
                            borderRadius: BorderRadius.circular(4.0)),
                        color: Colors.white,
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          style: new TextStyle(
                            color: theme.Colors.colorTextBlackInputCuti,
                            fontSize: 15.0,
                          ),
                          hint: _dropDownHint,
                          value: _selectedKeterangan,
                          items: _dropDownMenuItems,
                          isExpanded: true,
                          onChanged: changedDropDownItem,
                        ),
                      )),
                  Container(
                      margin: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Tanggal',
                        style: TextStyle(
                          color: theme.Colors.colorTextBlackInputCuti,
                          fontSize: 15.0,
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: Alignment(-1, 0),
                              height: 30.0,
                              width: widthDevice * .4,
                              padding: EdgeInsets.only(left: 8.0, right: 24.0),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0,
                                        style: BorderStyle.solid,
                                        color: theme
                                            .Colors.borderInputFieldInputCuti),
                                    borderRadius: BorderRadius.circular(4.0)),
                                color: Colors.white,
                              ),
                              child: _dateStart == null
                                  ? Text(
                                      'Dari',
                                      style: TextStyle(
                                          color: theme
                                              .Colors.colorTextGrayInputCuti,
                                          fontSize: 15.0),
                                    )
                                  : Text(
                                      DateFormat("dd-MM-yyyy")
                                          .format(_dateStart)
                                          .toString(),
                                      style: TextStyle(
                                          color: theme
                                              .Colors.colorTextBlackInputCuti,
                                          fontSize: 15.0),
                                    ),
                            ),
                            Container(
                              height: 30.0,
                              width: widthDevice * .4,
                              padding: EdgeInsets.only(right: 6.0),
                              child: Icon(
                                Icons.date_range,
                                color: theme.Colors.colorTextGrayInputCuti,
                              ),
                              alignment: Alignment(1, 0),
                            ),
                          ],
                        ),
                        onTap: () {
                          showDatePicker(
                              context: context,
                              initialDate: _dateStart == null
                                  ? DateTime.now()
                                  : _dateStart,
                              firstDate: DateTime(2001),
                              lastDate: DateTime(2021),
                              builder: (BuildContext context, Widget child) {
                                return Theme(
                                  data: ThemeData.light(),
                                  child: child,
                                );
                              }).then((date) {
                            setState(() {
                              _dateStart = date;
                            });
                          });
                        },
                      ),
                      GestureDetector(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              alignment: Alignment(-1, 0),
                              height: 30.0,
                              width: widthDevice * .4,
                              padding: EdgeInsets.only(left: 8.0, right: 24.0),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 0,
                                        style: BorderStyle.solid,
                                        color: theme
                                            .Colors.borderInputFieldInputCuti),
                                    borderRadius: BorderRadius.circular(4.0)),
                                color: Colors.white,
                              ),
                              child: _dateEnd == null
                                  ? Text(
                                      'Sampai',
                                      style: TextStyle(
                                          color: theme
                                              .Colors.colorTextGrayInputCuti,
                                          fontSize: 15.0),
                                    )
                                  : Text(
                                      DateFormat("dd-MM-yyyy")
                                          .format(_dateEnd)
                                          .toString(),
                                      style: TextStyle(
                                          color: theme
                                              .Colors.colorTextBlackInputCuti,
                                          fontSize: 15.0),
                                    ),
                            ),
                            Container(
                              height: 30.0,
                              width: widthDevice * .4,
                              padding: EdgeInsets.only(right: 6.0),
                              child: Icon(
                                Icons.date_range,
                                color: theme.Colors.colorTextGrayInputCuti,
                              ),
                              alignment: Alignment(1, 0),
                            ),
                          ],
                        ),
                        onTap: () {
                          showDatePicker(
                              context: context,
                              initialDate:
                                  _dateEnd == null ? DateTime.now() : _dateEnd,
                              firstDate: DateTime(2001),
                              lastDate: DateTime(2021),
                              builder: (BuildContext context, Widget child) {
                                return Theme(
                                  data: ThemeData.light(),
                                  child: child,
                                );
                              }).then((date) {
                            setState(() {
                              _dateEnd = date;
                            });
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        value: cutiLibur,
                        onChanged: (bool value) {
                          setState(() {
                            cutiLibur = value;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'Cuti pada hari sabtu, minggu dan hari libur',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: theme.Colors.colorTextBlackInputCuti),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
