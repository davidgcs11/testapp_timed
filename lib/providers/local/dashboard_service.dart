import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:provider/provider.dart';
import 'package:testtimed/pages/settings/settings_page.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:testtimed/providers/global/auth_service.dart';

class DashboardService with ChangeNotifier {
  SocketIO socketIO;

  DashboardService(BuildContext context) {
    setupSocketIO(context);
  }

  setupSocketIO(BuildContext context) async {
    socketIO = SocketIOManager().createSocketIO(
      'https://socketio-chat-example.now.sh',
      '/',
      socketStatusCallback: (data) => print(data),
    );

    await socketIO.init();
    //Subscribe to an event to listen to
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    Map<String, String> userData = {
      'username': authService.user.username,
    };
    await socketIO.sendMessage('add user', json.encode(userData));
    await socketIO.subscribe('new message', (jsonData) {
      Map<String, dynamic> data = json.decode(jsonData);
      print(data);
    });
    //Connect to the socket
    await socketIO.connect();
  }

  goToSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SettingsPage(),
      ),
    );
  }
}
