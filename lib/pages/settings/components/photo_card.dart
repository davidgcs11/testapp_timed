import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtimed/models/user_model.dart';
import 'package:testtimed/providers/local/settings_service.dart';

class PhotoCard extends StatelessWidget {
  final int photoIndex;
  const PhotoCard({Key key, @required this.photoIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String photoURL = parsePhotoToLocal(Photo.values[photoIndex]);
    SettingService settingService = Provider.of<SettingService>(context);
    bool isSelectedPhoto = photoIndex == settingService.selectedPhoto;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => settingService.selectNewIndex(photoIndex),
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
