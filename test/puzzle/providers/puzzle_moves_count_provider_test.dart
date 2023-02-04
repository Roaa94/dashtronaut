import 'package:dashtronaut/configs/models/configs.dart';
import 'package:dashtronaut/configs/providers/configs_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_moves_count_provider.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../utils/test_data.dart';

void main() {
  late PuzzleStorageRepository mockPuzzleRepository;

  setUp(() {
    mockPuzzleRepository = MockPuzzleStorageRepository();
  });

  test('initialized with 0 value', () {
    final providerContainer = ProviderContainer(
      overrides: [
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
      ],
    );

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(puzzleMovesCountProvider),
      equals(0),
    );
  });

  test('initialized with data from repository when available', () {
    const movesCount = 10;
    when(mockPuzzleRepository.get).thenReturn(
      puzzle2x2Solved.copyWith(movesCount: movesCount),
    );

    final providerContainer = ProviderContainer(
      overrides: [
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
      ],
    );

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(puzzleMovesCountProvider),
      equals(movesCount),
    );
  });

  test('updates state', () {
    final puzzleMovesCountListener = Listener<int>();
    const newValue = 2;
    final configs = Configs();

    when(() => mockPuzzleRepository.updateMovesCount(newValue))
        .thenAnswer((_) {});

    final providerContainer = ProviderContainer(
      overrides: [
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        configsProvider.overrideWithValue(configs),
      ],
    );

    addTearDown(providerContainer.dispose);

    puzzleMovesCountProvider.addListener(
      providerContainer,
      puzzleMovesCountListener,
      onError: (_, __) {},
      onDependencyMayHaveChanged: () {},
      fireImmediately: true,
    );
    verify(() => puzzleMovesCountListener(null, 0)).called(1);

    providerContainer.read(puzzleMovesCountProvider.notifier).update(newValue);

    verify(() => puzzleMovesCountListener(0, newValue)).called(1);
    expect(
      providerContainer.read(puzzleMovesCountProvider),
      equals(newValue),
    );
    verifyNoMoreInteractions(puzzleMovesCountListener);
  });

  test('updates repository when state is updated', () {
    const newValue = 2;

    when(() => mockPuzzleRepository.updateMovesCount(newValue))
        .thenAnswer((_) {});

    final providerContainer = ProviderContainer(
      overrides: [
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
      ],
    );

    addTearDown(providerContainer.dispose);

    providerContainer.read(puzzleMovesCountProvider.notifier).update(newValue);

    verify(() => mockPuzzleRepository.updateMovesCount(newValue)).called(1);
  });
}
