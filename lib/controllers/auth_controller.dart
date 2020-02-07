import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testtimed/models/user_model.dart';

class AuthController {
  static Future<User> getSavedUser() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    List<String> keys = shared.getKeys().toList();
    if (keys.contains('username') && keys.contains('photoIndex')) {
      String username = shared.getString('username');
      int photoIndex = shared.getInt('photoIndex');
      Photo photo = Photo.values[photoIndex];
      return User(
        username: username,
        photo: photo,
      );
    } else {
      return null;
    }
  }

  static Future<void> saveUser(User user) async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    bool username = await shared.setString('username', user.username);
    bool index = await shared.setInt('photoIndex', user.photo.index);
    await Fluttertoast.cancel();
    if (index && username) {
      Fluttertoast.showToast(msg: 'Credenciales guardadas');
    } else {
      Fluttertoast.showToast(msg: '¡ERROR! Credenciales no guardadas');
    }
  }

  static Future<void> deleteUser() async {
    SharedPreferences shared = await SharedPreferences.getInstance();
    bool username = await shared.remove('username');
    bool index = await shared.remove('photoIndex');
    await Fluttertoast.cancel();
    if (index && username) {
      Fluttertoast.showToast(msg: 'Credenciales borradas');
    } else {
      Fluttertoast.showToast(msg: '¡ERROR! Credenciales no borradas');
    }
  }
}
