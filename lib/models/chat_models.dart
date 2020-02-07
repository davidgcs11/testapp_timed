import 'package:flutter/cupertino.dart';
import 'package:testtimed/models/user_model.dart';
class Message {
  final String message;
  final String username;
  String photoURL;

  Message({
    @required this.message,
    @required this.username,
    this.photoURL
  }) {
    try{
      String imageID = username.split('#').last;
      int imageInt = int.parse(imageID);
      this.photoURL = parsePhotoToLocal(Photo.values[imageInt]);
    } catch (e) {
      this.photoURL = parsePhotoToLocal(Photo.values[0]);
    }
  }
}
