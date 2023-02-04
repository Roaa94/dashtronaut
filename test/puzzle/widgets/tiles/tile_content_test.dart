import 'package:dashtronaut/configs/models/configs.dart';
import 'package:dashtronaut/configs/providers/configs_provider.dart';
import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/layout/puzzle_layout.dart';
import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_is_solved_provider.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:dashtronaut/puzzle/widgets/tile/tile_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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

  group('Tile size animation on mouse enter/exit', () {
    testWidgets(
      'Tile size shrinks to ${AnimationsManager.tileHover.tween.end} '
      'when mouse enters tile area and puzzle is not solved yet',
      (WidgetTester tester) async {
        await tester.pumpProviderApp(
          const TileContent(tile: tile),
          overrides: [
            puzzleIsSolvedProvider.overrideWithValue(false),
            puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          ],
        );

        final gesture = await tester.createGesture(
          kind: PointerDeviceKind.mouse,
        );
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(MouseRegion).first));

        var tileContentWidgetState =
            tester.state(find.byType(TileContent)) as TileContentState;

        expect(
          tileContentWidgetState.animationController.isAnimating,
          isTrue,
        );
        await tester.pumpAndSettle();

        final scaleTransitionWidgetFinder = find.byType(ScaleTransition);
        final scaleTransitionWidget =
            tester.widget(scaleTransitionWidgetFinder) as ScaleTransition;

        tileContentWidgetState =
            tester.state(find.byType(TileContent)) as TileContentState;

        expect(
          scaleTransitionWidget.scale.value,
          equals(AnimationsManager.tileHover.tween.end),
        );

        expect(
          tileContentWidgetState.animationController.isCompleted,
          isTrue,
        );
      },
    );

    testWidgets(
      'Tile size returns to ${AnimationsManager.tileHover.tween.begin} '
      'when mouse leaves tile area and puzzle is not solved yet',
      (WidgetTester tester) async {
        await tester.pumpProviderApp(
          const TileContent(tile: tile),
          overrides: [
            puzzleIsSolvedProvider.overrideWithValue(false),
            puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          ],
        );

        final gesture = await tester.createGesture(
          kind: PointerDeviceKind.mouse,
        );
        await gesture.addPointer(
          location: tester.getCenter(find.byType(MouseRegion).first),
        );
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(const Offset(-100, -100));
        await tester.pumpAndSettle();

        final scaleTransitionWidgetFinder = find.byType(ScaleTransition);
        final scaleTransitionWidget =
            tester.widget(scaleTransitionWidgetFinder) as ScaleTransition;

        expect(
          scaleTransitionWidget.scale.value,
          equals(AnimationsManager.tileHover.tween.begin),
        );
      },
    );

    testWidgets(
      'Tile size animation does not trigger '
      'when mouse enters tile area and puzzle is already solved',
      (WidgetTester tester) async {
        await tester.pumpProviderApp(
          const TileContent(tile: tile),
          overrides: [
            puzzleIsSolvedProvider.overrideWithValue(true),
            puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
          ],
        );

        final gesture = await tester.createGesture(
          kind: PointerDeviceKind.mouse,
        );
        await gesture.addPointer(location: Offset.zero);
        addTearDown(gesture.removePointer);
        await tester.pump();

        await gesture.moveTo(tester.getCenter(find.byType(MouseRegion).first));
        var tileContentWidgetState =
            tester.state(find.byType(TileContent)) as TileContentState;
        expect(
          tileContentWidgetState.animationController.isAnimating,
          isFalse,
        );

        await tester.pumpAndSettle();

        tileContentWidgetState =
            tester.state(find.byType(TileContent)) as TileContentState;

        expect(
          tileContentWidgetState.animationController.isCompleted,
          isFalse,
        );
      },
    );
  });
}
