import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:dashtronaut/score/models/score.dart';
import 'package:dashtronaut/score/repositories/scores_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';

void main() {
  late StorageService hiveStorageService;
  late ScoresStorageRepository scoresStorageRepository;

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
}
