import 'package:dashtronaut/configs/models/configs.dart';
import 'package:dashtronaut/configs/providers/configs_provider.dart';
import 'package:dashtronaut/score/models/score.dart';
import 'package:dashtronaut/score/providers/scores_provider.dart';
import 'package:dashtronaut/score/repositories/scores_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';

void main() {
  final scoresRepository = MockScoresRepository();

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

  test('initializes with an empty array', () {
    final scoresListener = Listener<List<Score>>();

    final providerContainer = ProviderContainer(
      overrides: [
        scoresRepositoryProvider.overrideWithValue(scoresRepository),
      ],
    );

    addTearDown(providerContainer.dispose);

    providerContainer.listen(
      scoresProvider,
      scoresListener,
      fireImmediately: true,
    );

    final firstReading = providerContainer.read(scoresProvider);
    verify(() => scoresListener(null, [])).called(1);
    expect(firstReading, []);
  });

  test('initializes with data from storage', () {
    when(scoresRepository.get).thenReturn(scores);

    final scoresListener = Listener<List<Score>>();

    final providerContainer = ProviderContainer(
      overrides: [
        scoresRepositoryProvider.overrideWithValue(scoresRepository),
      ],
    );

    addTearDown(providerContainer.dispose);

    providerContainer.listen(
      scoresProvider,
      scoresListener,
      fireImmediately: true,
    );

    final firstReading = providerContainer.read(scoresProvider);
    verify(() => scoresListener(null, scores)).called(1);
    expect(firstReading, scores);
  });

  test('can add new score', () {
    when(scoresRepository.get).thenReturn([]);

    final scoresListener = Listener<List<Score>>();

    final providerContainer = ProviderContainer(
      overrides: [
        scoresRepositoryProvider.overrideWithValue(scoresRepository),
      ],
    );

    addTearDown(providerContainer.dispose);

    providerContainer.listen(
      scoresProvider,
      scoresListener,
      fireImmediately: true,
    );

    const newScore = Score(
      secondsElapsed: 30,
      winMovesCount: 15,
      puzzleSize: 5,
    );

    providerContainer.read(scoresProvider).add(newScore);
    verify(() => scoresListener(null, [newScore])).called(1);

    expect(
      providerContainer.read(scoresProvider),
      equals([newScore]),
    );
  });

  test('removes first score when storable score limit is reached', () {
    when(scoresRepository.get).thenReturn(scores);

    final scoresListener = Listener<List<Score>>();

    final providerContainer = ProviderContainer(
      overrides: [
        scoresRepositoryProvider.overrideWithValue(scoresRepository),
        configsProvider
            .overrideWithValue(Configs(maxStorableScores: scores.length)),
      ],
    );

    addTearDown(providerContainer.dispose);

    providerContainer.listen(
      scoresProvider,
      scoresListener,
      fireImmediately: true,
    );

    const newScore = Score(
      secondsElapsed: 30,
      winMovesCount: 15,
      puzzleSize: 5,
    );

    verify(() => scoresListener(null, scores)).called(1);

    providerContainer.read(scoresProvider.notifier).addScore(newScore);
    final trimmedScores = scores.toList();
    trimmedScores.removeAt(0);
    verify(() => scoresListener(scores, [...trimmedScores, newScore]))
        .called(1);

    expect(
      providerContainer.read(scoresProvider),
      equals([...trimmedScores, newScore]),
    );
  });
}
