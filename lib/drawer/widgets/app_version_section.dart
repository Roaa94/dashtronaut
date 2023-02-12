import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionSection extends StatefulWidget {
  const AppVersionSection({super.key});

  @override
  _AppVersionSectionState createState() => _AppVersionSectionState();
}

class _AppVersionSectionState extends State<AppVersionSection> {
  String? appVersionText;

  Future<void> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    setState(() {
      appVersionText = '$version.$buildNumber';
    });
  }

  @override
  void initState() {
    getPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Version ${appVersionText ?? ''}',
      style: AppTextStyles.bodyXs,
    );
  }
}
