import 'package:dashtronaut/puzzle/providers/puzzle_moves_count_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_provider.dart';
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

  test('Returns 2 for a puzzle with 2 move counts', () {
    when(() => mockPuzzleRepository.get())
        .thenReturn(puzzle2x2.copyWith(movesCount: 2));

    final providerContainer = ProviderContainer(
      overrides: [
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
      ],
    );

    addTearDown(providerContainer.dispose);

    expect(
      providerContainer.read(puzzleMovesCountProvider),
      equals(2),
    );
  });

  test('Value updated when puzzleProvider.movesCount value is updated',
      () async {
    when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2Solvable);

    final movesCountListener = Listener<int>();

    final providerContainer = ProviderContainer(
      overrides: [
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
      ],
    );
    addTearDown(providerContainer.dispose);

    providerContainer.listen(
      puzzleMovesCountProvider,
      movesCountListener,
      fireImmediately: true,
    );

    providerContainer.read(puzzleProvider.notifier).swapTiles(
          puzzle2x2Solvable.tiles.firstWhere((tile) => tile.value == 1),
        );
    await Future.delayed(Duration.zero);

    verifyInOrder([
      () => movesCountListener.call(null, 0),
      () => movesCountListener.call(0, 1),
    ]);
  });

  test('Value not updated when puzzleProvider.movesCount value is not updated',
      () async {
    when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2Solvable);

    final movesCountListener = Listener<int>();

    final providerContainer = ProviderContainer(
      overrides: [
        puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
      ],
    );
    addTearDown(providerContainer.dispose);

    providerContainer.listen(
      puzzleMovesCountProvider,
      movesCountListener,
      fireImmediately: true,
    );
    verify(() => movesCountListener.call(null, 0));

    // If moves count is already 0, resetting the puzzle should not update
    // the movesCountProvider
    providerContainer.read(puzzleProvider.notifier).reset();
    await Future.delayed(Duration.zero);

    verifyNoMoreInteractions(movesCountListener);
  });
}
