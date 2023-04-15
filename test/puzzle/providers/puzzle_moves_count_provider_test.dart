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
}
