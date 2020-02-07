import 'package:flutter/material.dart';
import 'package:testtimed/pages/settings/settings_page.dart';

class DashboardService with ChangeNotifier {
  goToSettings(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SettingsPage(),
      ),
    );
  }
}
