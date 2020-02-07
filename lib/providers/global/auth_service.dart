import 'package:flutter/foundation.dart';
import 'package:testtimed/controllers/auth_controller.dart';
import 'package:testtimed/models/user_model.dart';

class AuthService with ChangeNotifier {
  User user;
  String initialRoute;

  initiateService() async {
    user = await AuthController.getSavedUser();
    if (user == null) {
      initialRoute = 'login';
    } else {
      initialRoute = 'dashboard';
    }
    notifyListeners();
  }

  Future<void> setUser(User newUser) async {
    user = newUser;
    await AuthController.saveUser(newUser);
    notifyListeners();
  }

  Future<void> logout() async {
    user = null;
    await AuthController.deleteUser();
    notifyListeners();
  }
}
