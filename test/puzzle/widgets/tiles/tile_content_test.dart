import 'package:dashtronaut/configs/models/configs.dart';
import 'package:dashtronaut/configs/providers/configs_provider.dart';
import 'package:dashtronaut/core/layout/puzzle_layout.dart';
import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_is_solved_provider.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:dashtronaut/puzzle/widgets/tile/tile_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';
import '../../../utils/pump_app.dart';
import '../../../utils/test_data.dart';

void main() {
  const tile = Tile(
    value: 3,
    currentLocation: Location(x: 2, y: 2),
    correctLocation: Location(x: 1, y: 2),
  );

  late PuzzleStorageRepository mockPuzzleRepository;

  setUp(() {
    mockPuzzleRepository = MockPuzzleStorageRepository();
  });

  group('Tile padding tests', () {
    testWidgets(
      'Tile padding is ${PuzzleLayout.tilePadding} '
      'when puzzle size is less than configs.smallTilePuzzleSize',
      (WidgetTester tester) async {
        const smallTilePuzzleSize = 4;

        when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2);

        await tester.pumpProviderApp(
          const TileContent(tile: tile),
          overrides: [
            configsProvider.overrideWithValue(
              const Configs(smallTilePuzzleSize: smallTilePuzzleSize),
            ),
            puzzleIsSolvedProvider.overrideWithValue(false),
            puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          ],
        );
        await tester.pumpAndSettle();

        final paddingWidgetFinder = find.byType(Padding).first;
        final paddingWidget = tester.widget(paddingWidgetFinder) as Padding;

        expect(
          paddingWidget.padding,
          equals(const EdgeInsets.all(PuzzleLayout.tilePadding)),
        );
      },
    );

    testWidgets(
      'Tile padding is ${PuzzleLayout.smallTilePadding} '
      'when puzzle size is more than configs.smallTilePuzzleSize',
      (WidgetTester tester) async {
        const smallTilePuzzleSize = 1;

        when(() => mockPuzzleRepository.get()).thenReturn(puzzle2x2);

        await tester.pumpProviderApp(
          const TileContent(tile: tile),
          overrides: [
            configsProvider.overrideWithValue(
              const Configs(smallTilePuzzleSize: smallTilePuzzleSize),
            ),
            puzzleIsSolvedProvider.overrideWithValue(false),
            puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          ],
        );
        await tester.pumpAndSettle();

        final paddingWidgetFinder = find.byType(Padding).first;
        final paddingWidget = tester.widget(paddingWidgetFinder) as Padding;

        expect(
          paddingWidget.padding,
          equals(const EdgeInsets.all(PuzzleLayout.smallTilePadding)),
        );
      },
    );
  });
}
