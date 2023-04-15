import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

final urlLauncherServiceProvider = Provider<UrlService>(
  (_) => UrlLauncherService(),
);

abstract class UrlService {
  Future<void> openLink(String url);
}

class UrlLauncherService extends UrlService {
  @override
  Future<void> openLink(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Url cannot be opened!';
    }
  }
}
