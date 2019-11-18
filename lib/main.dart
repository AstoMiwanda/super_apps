import 'package:flutter/material.dart';
import 'package:super_apps/ui/detail_cuti_page.dart';
import 'package:super_apps/style/string.dart' as string;
import 'package:super_apps/ui/splash_screen_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: string.text.lbl_aplikasi,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: DetailCutiPage(),
    );
  }
}

