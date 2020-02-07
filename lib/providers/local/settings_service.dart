import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:testtimed/models/user_model.dart';
import 'package:testtimed/pages/login/login_page.dart';
import 'package:testtimed/providers/global/auth_service.dart';

class SettingService with ChangeNotifier {
  TextEditingController usernameController;
  int selectedPhoto;

  SettingService(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    if (authService.user == null) {
      usernameController = TextEditingController();
      selectedPhoto = 0;
    } else {
      usernameController =
          TextEditingController(text: authService.user.username);
      selectedPhoto = authService.user.photo.index;
    }
  }

  bool validateUsername({String input}) {
    String text = input ?? usernameController.text;
    return RegExp('^.{5,}').hasMatch(text);
  }

  void selectNewIndex(int index) {
    selectedPhoto = index;
    notifyListeners();
  }

  save(BuildContext context) async {
    if (validateUsername()) {
      AuthService authService =
          Provider.of<AuthService>(context, listen: false);
      User newUser = User(
        username: usernameController.text,
        photo: Photo.values[selectedPhoto],
      );
      await authService.setUser(newUser);
      await Fluttertoast.cancel();
      Fluttertoast.showToast(msg: 'Cambios guardados');
    } else {
      await Fluttertoast.cancel();
      Fluttertoast.showToast(msg: 'Escribe un usuario válido');
    }
  }

  logout(BuildContext context) async {
    AuthService authService = Provider.of<AuthService>(context, listen: false);
    await authService.logout();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
