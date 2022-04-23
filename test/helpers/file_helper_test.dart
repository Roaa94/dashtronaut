import 'dart:io';

import 'package:Dashtronaut/helpers/file_helper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

import '../mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('FileHelper', () {
    setUp(() async {
      PathProviderPlatform.instance = MockPathProviderPlatform();
    });

    test('getTemporaryDirectory', () async {
      final Directory result = await FileHelper.getTemporaryDirectory();
      expect(result.path, kTemporaryPath);
    });

    // Todo: make this test work
    test('returns file from asset', () async {
      String imageUrl =
          'https://dashtronaut.app/images/puzzle-solved/solved-3x3.png';
      var file = await FileHelper.getFileFromUrl(imageUrl);

      expect(file, isA<File>());
    }, skip: true);
  });
}
