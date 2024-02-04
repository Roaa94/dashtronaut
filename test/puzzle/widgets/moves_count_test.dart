import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:dashtronaut/puzzle/widgets/moves_count.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../utils/pump_app.dart';
import '../../utils/test_data.dart';

void main() {
  late PuzzleStorageRepository mockPuzzleRepository;

  setUp(() {
    mockPuzzleRepository = MockPuzzleStorageRepository();
  });

  testWidgets(
    'moves count displays correct count from storage',
    (WidgetTester tester) async {
      const movesCount = 10;
      when(mockPuzzleRepository.get).thenReturn(
        puzzle2x2.copyWith(movesCount: movesCount),
      );

      await tester.pumpProviderApp(
        const MovesCount(),
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );
      await tester.pumpAndSettle();

      expect(
        find.textContaining('$movesCount', findRichText: true),
        findsOneWidget,
      );
    },
  );
}
