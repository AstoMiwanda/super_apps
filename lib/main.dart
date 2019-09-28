import 'package:flutter/material.dart';
import 'package:super_apps/ui/login_page.dart';
import 'package:super_apps/style/string.dart' as string;
import 'package:super_apps/ui/splash_screen_page.dart';
import 'package:super_apps/ui/absen_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: string.Text.lbl_aplikasi,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: Absen(),
    );
  }
}

