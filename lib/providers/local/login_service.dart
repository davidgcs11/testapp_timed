import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:testtimed/models/user_model.dart';
import 'package:testtimed/pages/dashboard/dashboard_page.dart';
import 'package:testtimed/providers/global/auth_service.dart';

class LoginService with ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  int selectedPhoto = 0;

  login(BuildContext context) async {
    if (validateUsername()) {
      AuthService authService =
          Provider.of<AuthService>(context, listen: false);
      User newUser = User(
        username: usernameController.text,
        photo: Photo.values[selectedPhoto],
      );
      await authService.setUser(newUser);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => DashboardPage(),
        ),
      );
    } else {
      await Fluttertoast.cancel();
      Fluttertoast.showToast(msg: 'Escribe un usuario válido');
    }
  }

  void selectNewIndex(int index) {
    selectedPhoto = index;
    notifyListeners();
  }

  bool validateUsername({String input}) {
    String text = input ?? usernameController.text;
    return RegExp('^.{5,}').hasMatch(text);
  }
}
