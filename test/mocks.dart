import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:dashtronaut/score/repositories/scores_repository.dart';
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