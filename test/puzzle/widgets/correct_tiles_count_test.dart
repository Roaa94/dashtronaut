import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:dashtronaut/puzzle/widgets/correct_tiles_count.dart';
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
    'Displays correct value of correct tiles count and total tiles',
    (WidgetTester tester) async {
      when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2);

      await tester.pumpProviderApp(
        const CorrectTilesCount(),
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );
      await tester.pumpAndSettle();

      expect(
        find.textContaining('2/3', findRichText: true),
        findsOneWidget,
      );
    },
  );
}
