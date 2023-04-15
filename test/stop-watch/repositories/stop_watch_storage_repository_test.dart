import 'package:dashtronaut/core/services/storage/hive_storage_service.dart';
import 'package:dashtronaut/core/services/storage/storage_service.dart';
import 'package:dashtronaut/core/services/storage/storage_service_provider.dart';
import 'package:dashtronaut/stop-watch/repositories/stop_watch_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late StopWatchStorageRepository stopWatchStorageRepository;

  group('$StopWatchStorageRepository tests', () {
    late StorageService hiveStorageService;

    setUp(() async {
      hiveStorageService = HiveStorageService();
      await setUpTestHive();
      await hiveStorageService.init();

      stopWatchStorageRepository = StopWatchStorageRepository(
        hiveStorageService,
      );
    });

    test('can set stop watch elapsed seconds', () {
      const elapsedSeconds = 20;

      stopWatchStorageRepository.set(elapsedSeconds);

      expect(stopWatchStorageRepository.get(), elapsedSeconds);
    });
  });

  group('$stopWatchRepositoryProvider tests', () {
    late StorageService mockStorageService;

    setUp(() async {
      mockStorageService = MockStorageService();

      stopWatchStorageRepository = StopWatchStorageRepository(
        mockStorageService,
      );
    });

    test('can set stop watch elapsed seconds', () {
      final providerContainer = ProviderContainer(
        overrides: [
          storageServiceProvider.overrideWithValue(mockStorageService),
        ],
      );
      addTearDown(providerContainer.dispose);

      const elapsedSeconds = 20;

      try {
        providerContainer.read(stopWatchRepositoryProvider).set(elapsedSeconds);
      } catch (e) {
        //...
      }

      verify(
        () => mockStorageService.set(
          stopWatchStorageRepository.storageKey,
          elapsedSeconds,
        ),
      );
    });

    test('can get stop watch elapsed seconds', () {
      const elapsedSeconds = 20;
      final providerContainer = ProviderContainer(
        overrides: [
          storageServiceProvider.overrideWithValue(mockStorageService),
        ],
      );
      addTearDown(providerContainer.dispose);

      when(
        () => mockStorageService.get(stopWatchStorageRepository.storageKey),
      ).thenAnswer((_) => elapsedSeconds);

      providerContainer.read(stopWatchRepositoryProvider).get();

      verify(
        () => mockStorageService.get(stopWatchStorageRepository.storageKey),
      );
    });
  });
}
