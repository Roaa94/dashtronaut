import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsProvider with ChangeNotifier {
  String appVersionText = '';

  Future<void> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    appVersionText = '$version.$buildNumber';
    notifyListeners();
  }

  Future<void> bootActions() async {
    //...
  }
}
