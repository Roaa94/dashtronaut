import 'package:dashtronaut/core/constants.dart';
import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:dashtronaut/score/models/score.dart';
import 'package:dashtronaut/score/models/scores_data.dart';
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
      maxStorableScores: 2,
    );
  });

  test('Can add a score', () {
    const score = Score(
      secondsElapsed: 30,
      winMovesCount: 10,
      puzzleSize: 4,
    );

    scoresStorageRepository.add(score);
    expect(
      scoresStorageRepository.get(),
      const ScoresData(scores: [score]),
    );
  });

  test('Can add a score to existing list', () {
    const scores = [
      Score(
        secondsElapsed: 30,
        winMovesCount: 10,
        puzzleSize: 4,
      ),
    ];
    scoresStorageRepository.set(
      const ScoresData(scores: scores),
    );

    const newScore = Score(
      secondsElapsed: 30,
      winMovesCount: 15,
      puzzleSize: 5,
    );

    scoresStorageRepository.add(newScore);
    expect(
      scoresStorageRepository.get(),
      const ScoresData(
        scores: [...scores, newScore],
      ),
    );
  });

  test(
    'Removes first score when adding a new one'
    ' if list length exceeds ${Constants.maxStorableScores}',
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
      scoresStorageRepository.set(
        const ScoresData(scores: scores),
      );

      const newScore = Score(
        secondsElapsed: 30,
        winMovesCount: 15,
        puzzleSize: 5,
      );

      const newScores = [
        Score(
          secondsElapsed: 30,
          winMovesCount: 15,
          puzzleSize: 5,
        ),
        newScore,
      ];

      scoresStorageRepository.add(newScore);
      expect(
        scoresStorageRepository.get(),
        const ScoresData(scores: newScores),
      );
    },
  );

  tearDown(() async {
    await hiveStorageService.close();
  });
}
