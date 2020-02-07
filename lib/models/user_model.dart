import 'package:flutter/cupertino.dart';

enum Photo {
  happy,
  mad,
  sad,
  training,
}

class User {
  String username;
  Photo photo;
  String photoURL;

  User({@required this.photo, @required this.username}) {
    photoURL = parsePhotoToLocal(photo);
  }

  changePhoto(Photo newPhoto) {
    photoURL = parsePhotoToLocal(newPhoto);
  }
}

String parsePhotoToLocal(Photo photo) {
  switch (photo) {
    case Photo.happy:
      return 'assets/images/alegre.webp';
    case Photo.mad:
      return 'assets/images/molesto.webp';
    case Photo.sad:
      return 'assets/images/asustado.webp';
    case Photo.training:
      return 'assets/images/pesas.webp';
    default:
      return 'assets/images/cansado.webp';
  }
}
