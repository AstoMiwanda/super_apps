import 'package:flutter/material.dart';
import 'package:super_apps/ui/login_page.dart';
import 'package:super_apps/style/string.dart' as string;
import 'package:super_apps/ui/splash_screen_page.dart';
import 'package:super_apps/ui/websocket_learn_page.dart';
import 'package:web_socket_channel/io.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: string.text.lbl_aplikasi,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: WebSocketPage(
        title: 'WebSocket Demo',
        channel: IOWebSocketChannel.connect('ws://echo.websocket.org'),
      ),
    );
  }
}

