import 'package:flutter/material.dart';
import 'package:adhara_socket_io/adhara_socket_io.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:testtimed/models/chat_models.dart';
import 'package:testtimed/models/user_model.dart';
import 'package:testtimed/pages/settings/settings_page.dart';
import 'package:testtimed/providers/global/auth_service.dart';

class DashboardService with ChangeNotifier {
  SocketIO socketIO;
  int numUsers;
  bool isLoading = true;
  List<User> users = [];
  List<Message> messages = [];

  DashboardService(BuildContext context) {
    setupSocketIO(context);
  }

  setupSocketIO(BuildContext context) async {
    SocketIOManager manager = SocketIOManager();
    this.socketIO = await manager
        .createInstance(SocketOptions('https://socketio-chat-example.now.sh/'));
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    socketIO.onConnect((data) {
      socketIO.emit("add user", [
        authService.user.username +
            '#' +
            authService.user.photo.index.toString()
      ]);
    });
    socketIO.on("new message", (data) {
      String message = data['message'];
      String username = data['username'];
      this.messages.add(Message(
            message: message,
            username: username,
          ));
      notifyListeners();
    });
    socketIO.on("login", (data) {
      numUsers = data['numUsers'];
      notifyListeners();
    });
    socketIO.on('user joined', (data) async {
      print('NEW joined: $data');
      await addUser(data['username']);
      numUsers = data['numUsers'];
      notifyListeners();
    });
    socketIO.on('user left', (data) async {
      print('NEW left: $data');
      await removeUser(data['username']);
      numUsers = data['numUsers'];
      notifyListeners();
    });
    socketIO.connect();
    isLoading = false;
    notifyListeners();
  }

  addUser(String username) async {
    if (!users.any((user) => user.username == username)) {
      Photo photo;
      try {
        String imageID = username.split('#').last;
        int imageInt = int.parse(imageID);
        photo = Photo.values[imageInt];
      } catch (e) {
        photo = Photo.values[0];
      }
      users.add(
        User(
          username: username,
          photo: photo,
        ),
      );
      notifyListeners();
      await Fluttertoast.cancel();
      Fluttertoast.showToast(msg: '$username se ha unido a la sala');
    }
  }

  removeUser(String username) async {
    if (users.any((user) => user.username == username)) {
      User user = users.firstWhere((user) => user.username == username);
      users.remove(user);
      notifyListeners();
      await Fluttertoast.cancel();
      Fluttertoast.showToast(msg: '$username ha dejado la sala');
    }
  }

  goToSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SettingsPage(),
      ),
    );
  }
}
