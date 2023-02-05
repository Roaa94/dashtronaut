import 'dart:io';
import 'dart:typed_data';

import 'package:dashtronaut/core/services/http/http_service.dart';
import 'package:dashtronaut/core/services/share-score/file_share_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:share_plus_platform_interface/share_plus_platform_interface.dart';

import '../../../mocks.dart';

class MockSharePlatform extends Mock implements SharePlatform {}

class MockShareResult extends Mock implements ShareResult {}

void main() {
  const testUrl = 'https://test.url';
  late XFileShareService xFileShareService;
  late HttpService httpService;
  late SharePlatform sharePlatform;

  setUp(() {
    httpService = MockHttpService();
    sharePlatform = MockSharePlatform();
    xFileShareService = XFileShareService(httpService, sharePlatform);
    PathProviderPlatform.instance = MockPathProviderPlatform();

    when(() => httpService.getBytes(testUrl)).thenAnswer(
      (_) async => Uint8List(0),
    );
  });

  test('getTemporaryDirectory', () async {
    final Directory result = await xFileShareService.getTemporaryDirectory();
    expect(result.path, kTemporaryPath);
  });

  test('getFileFromUrl calls httpsService.getBytes', () async {
    IOOverrides.runZoned(
      () async {
        await xFileShareService.getFileFromUrl(testUrl);
      },
      createFile: (String path) => MockFile(path),
    );

    verify(() => httpService.getBytes(testUrl)).called(1);
  });

  test('shareFileFromUrl calls shareXFiles successfully', () async {
    const shareText = 'share';
    const filePath = '$kTemporaryPath/file.png';
    when(
      () => sharePlatform.shareXFiles(
        any(),
        text: shareText,
      ),
    ).thenAnswer((_) async => MockShareResult());

    IOOverrides.runZoned(
      () async {
        await xFileShareService.shareFileFromUrl(
          url: testUrl,
          shareText: shareText,
        );

        verify(
          () => sharePlatform.shareXFiles(
            any(),
            text: shareText,
          ),
        ).called(1);
      },
      createFile: (String path) => MockFile(path),
    );
  });
}
