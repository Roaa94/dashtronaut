import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/puzzle/widgets/tile/tile_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../utils/pump_app.dart';

void main() {
  const tile = Tile(
    value: 3,
    currentLocation: Location(x: 2, y: 2),
    correctLocation: Location(x: 1, y: 2),
  );

  group('Tile size animation on mouse enter/exit', () {
    testWidgets(
      'Tile size shrinks to ${AnimationsManager.tileHover.tween.end} '
      'when mouse enters tile area and puzzle is not solved yet',
      (WidgetTester tester) async {
        await tester.pumpProviderApp(
          const TileContent(
            tile: tile,
            isPuzzleSolved: false,
            puzzleSize: 3,
          ),
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
          const TileContent(
            tile: tile,
            isPuzzleSolved: false,
            puzzleSize: 3,
          ),
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
          const TileContent(
            tile: tile,
            isPuzzleSolved: true,
            puzzleSize: 3,
          ),
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
