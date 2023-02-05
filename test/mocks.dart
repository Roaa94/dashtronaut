import 'package:dashtronaut/core/services/share-score/file_share_service.dart';
import 'package:dashtronaut/core/services/share-score/share_score_service.dart';
import 'package:dashtronaut/core/services/share-score/url_service.dart';
import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:dashtronaut/score/repositories/scores_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

const String kTemporaryPath = 'temporaryPath';

class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    return kTemporaryPath;
  }
}

class MockScoresRepository extends Mock implements ScoresStorageRepository {}

class Listener<T> extends Mock {
  void call(T? previous, T value);
}

class MockStorageService extends Mock implements StorageService {}

class MockPuzzleStorageRepository extends Mock
    implements PuzzleStorageRepository {}

class MockPuzzleSizeNotifier extends Mock
    implements PuzzleSizeNotifier, Notifier<int> {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockRoute extends Mock implements Route<dynamic> {}

class MockShareScoreService extends Mock implements ShareScoreService {}

class MockUrlService extends Mock implements UrlService {}

class MockFileShareService extends Mock implements FileShareService {}

class MockUrlLauncher extends Mock
    with MockPlatformInterfaceMixin
    implements UrlLauncherPlatform {}

class MockLaunchOptions extends Mock implements LaunchOptions {}
