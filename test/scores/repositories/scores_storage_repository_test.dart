import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:dashtronaut/score/models/score.dart';
import 'package:dashtronaut/score/repositories/scores_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  late ScoresStorageRepository scoresStorageRepository;

  group('$ScoresStorageRepository tests', () {
    late StorageService hiveStorageService;

    setUp(() async {
      hiveStorageService = HiveStorageService();
      await setUpTestHive();
      await hiveStorageService.init();

      scoresStorageRepository = ScoresStorageRepository(
        hiveStorageService,
      );
    });

    test(
      'can set scores',
      () {
        const scores = [
          Score(
            secondsElapsed: 30,
            winMovesCount: 10,
            puzzleSize: 4,
          ),
          Score(
            secondsElapsed: 30,
            winMovesCount: 15,
            puzzleSize: 5,
          ),
        ];
        scoresStorageRepository.set(scores);

        expect(scoresStorageRepository.get(), equals(scores));
      },
    );

    tearDown(() async {
      await hiveStorageService.close();
    });
  });

  group('$scoresRepositoryProvider tests', () {
    late StorageService mockStorageService;
    const scores = [
      Score(
        secondsElapsed: 30,
        winMovesCount: 10,
        puzzleSize: 4,
      ),
      Score(
        secondsElapsed: 30,
        winMovesCount: 15,
        puzzleSize: 5,
      ),
    ];

    setUp(() {
      mockStorageService = MockStorageService();
      scoresStorageRepository = ScoresStorageRepository(mockStorageService);
    });

    test(
      'calls set on storage service with correct data',
      () {
        final providerContainer = ProviderContainer(
          overrides: [
            storageServiceProvider.overrideWithValue(mockStorageService),
          ],
        );
        addTearDown(providerContainer.dispose);

        try {
          providerContainer.read(scoresRepositoryProvider).set(scores);
        } catch (_) {}

        verify(
          () => mockStorageService.set(
            scoresStorageRepository.storageKey,
            Score.toJsonList(scores),
          ),
        ).called(1);
      },
    );
  });
}
