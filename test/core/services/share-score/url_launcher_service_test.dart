import 'package:dashtronaut/core/services/share-score/url_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../../mocks.dart';

void main() {
  late UrlLauncherPlatform urlLauncher;
  late UrlService urlService;
  const testUrl = 'https://test.url';

  setUpAll(() {
    registerFallbackValue(MockLaunchOptions());
  });

  setUp(() {
    urlLauncher = MockUrlLauncher();
    UrlLauncherPlatform.instance = urlLauncher;
    urlService = UrlLauncherService();
  });

  test('calls launchUrl when url can be launched', () async {
    when(() => urlLauncher.canLaunch(testUrl)).thenAnswer((_) async => true);
    when(
      () => urlLauncher.launchUrl(testUrl, any()),
    ).thenAnswer((_) async => true);

    await urlService.openLink(testUrl);

    verify(
      () => urlLauncher.launchUrl(testUrl, any()),
    ).called(1);
  });

  test('Throws error when url cannot be opened', () async {
    when(() => urlLauncher.canLaunch(testUrl)).thenAnswer((_) async => false);

    expect(
      () => urlService.openLink(testUrl),
      throwsA('Url cannot be opened!'),
    );
  });
}
