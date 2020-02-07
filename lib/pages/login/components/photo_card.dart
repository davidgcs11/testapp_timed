import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtimed/models/user_model.dart';
import 'package:testtimed/providers/local/login_service.dart';

class PhotoCard extends StatelessWidget {
  final int photoIndex;
  const PhotoCard({Key key, @required this.photoIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String photoURL = parsePhotoToLocal(Photo.values[photoIndex]);
    LoginService loginService = Provider.of<LoginService>(context);
    bool isSelectedPhoto = photoIndex == loginService.selectedPhoto;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => loginService.selectNewIndex(photoIndex),
        child: Container(
          padding: EdgeInsets.all(5),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              isSelectedPhoto ? Colors.transparent : Colors.grey,
              isSelectedPhoto ? BlendMode.saturation : BlendMode.srcIn,
            ),
            child: Image.asset(photoURL),
          ),
        ),
      ),
    );
  }
}
