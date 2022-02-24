import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/services/service_locator.dart';
import 'package:flutter_puzzle_hack/services/storage/storage_service.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsProvider with ChangeNotifier {
  String appVersionText = '';
  final StorageService _storageService = getIt<StorageService>();

  Future<void> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    appVersionText = '$version.$buildNumber';
    notifyListeners();
  }

  Future<void> bootActions() async {
    await _storageService.init();
    // _storageService.clear();
  }
}
