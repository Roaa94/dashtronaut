import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/puzzle.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_keyboard_listener.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks.dart';
import '../../utils/pump_app.dart';

// 1  2
//    3
const tiles2x2AboveAndRightOfWhitespace = [
  Tile(
    value: 1,
    currentLocation: Location(x: 1, y: 1),
    correctLocation: Location(x: 1, y: 1),
  ),
  Tile(
    value: 2,
    currentLocation: Location(x: 2, y: 1),
    correctLocation: Location(x: 2, y: 1),
  ),
  Tile(
    value: 3,
    currentLocation: Location(x: 2, y: 2),
    correctLocation: Location(x: 1, y: 2),
  ),
  Tile(
    value: 4,
    tileIsWhiteSpace: true,
    currentLocation: Location(x: 1, y: 2),
    correctLocation: Location(x: 2, y: 2),
  ),
];

// 1  2
// 3
const tiles2x2AboveAndLeftOfWhitespace = [
  Tile(
    value: 1,
    currentLocation: Location(x: 1, y: 1),
    correctLocation: Location(x: 1, y: 1),
  ),
  Tile(
    value: 2,
    currentLocation: Location(x: 2, y: 1),
    correctLocation: Location(x: 2, y: 1),
  ),
  Tile(
    value: 3,
    correctLocation: Location(x: 1, y: 2),
    currentLocation: Location(x: 1, y: 2),
  ),
  Tile(
    value: 4,
    tileIsWhiteSpace: true,
    currentLocation: Location(x: 2, y: 2),
    correctLocation: Location(x: 2, y: 2),
  ),
];

// 1
// 3  2
const tiles2x2BelowAndLeftOfWhitespace = [
  Tile(
    value: 1,
    currentLocation: Location(x: 1, y: 1),
    correctLocation: Location(x: 1, y: 1),
  ),
  Tile(
    value: 2,
    currentLocation: Location(x: 2, y: 2),
    correctLocation: Location(x: 2, y: 1),
  ),
  Tile(
    value: 3,
    correctLocation: Location(x: 1, y: 2),
    currentLocation: Location(x: 1, y: 2),
  ),
  Tile(
    value: 4,
    tileIsWhiteSpace: true,
    currentLocation: Location(x: 2, y: 1),
    correctLocation: Location(x: 2, y: 2),
  ),
];

//    1
// 3  2
const tiles2x2BelowAndRightOfWhitespace1 = [
  Tile(
    value: 1,
    correctLocation: Location(x: 1, y: 1),
    currentLocation: Location(x: 2, y: 1),
  ),
  Tile(
    value: 2,
    currentLocation: Location(x: 2, y: 2),
    correctLocation: Location(x: 2, y: 1),
  ),
  Tile(
    value: 3,
    correctLocation: Location(x: 1, y: 2),
    currentLocation: Location(x: 1, y: 2),
  ),
  Tile(
    value: 4,
    currentLocation: Location(x: 1, y: 1),
    correctLocation: Location(x: 2, y: 2),
    tileIsWhiteSpace: true,
  ),
];

//    2
// 1  3
const tiles2x2BelowAndRightOfWhitespace2 = [
  Tile(
    value: 1,
    correctLocation: Location(x: 1, y: 1),
    currentLocation: Location(x: 1, y: 2),
  ),
  Tile(
    value: 2,
    currentLocation: Location(x: 2, y: 1),
    correctLocation: Location(x: 2, y: 1),
  ),
  Tile(
    value: 3,
    currentLocation: Location(x: 2, y: 2),
    correctLocation: Location(x: 1, y: 2),
  ),
  Tile(
    value: 4,
    currentLocation: Location(x: 1, y: 1),
    tileIsWhiteSpace: true,
    correctLocation: Location(x: 2, y: 2),
  ),
];

void main() {
  late PuzzleStorageRepository mockPuzzleRepository;
  const initialMovesCount = 10;

  setUp(() {
    mockPuzzleRepository = MockPuzzleStorageRepository();
  });

  testWidgets(
    'arrowDown Key event moves tile top of whitespace',
    (WidgetTester tester) async {
      when(() => mockPuzzleRepository.get()).thenReturn(
        const Puzzle(
          n: 2,
          tiles: tiles2x2AboveAndRightOfWhitespace,
          movesCount: initialMovesCount,
        ),
      );

      await tester.pumpProviderApp(
        PuzzleKeyboardListener(child: Container()),
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );

      await tester.sendKeyDownEvent(
        LogicalKeyboardKey.arrowDown,
        physicalKey: PhysicalKeyboardKey.arrowDown,
      );

      verify(
        () => mockPuzzleRepository.updatePuzzle(
          tiles: tiles2x2BelowAndRightOfWhitespace2,
          movesCount: initialMovesCount + 1,
        ),
      ).called(1);
    },
  );

  testWidgets(
    'arrowLeft Key event moves tile right of whitespace',
    (WidgetTester tester) async {
      when(() => mockPuzzleRepository.get()).thenReturn(
        const Puzzle(
          n: 2,
          tiles: tiles2x2AboveAndRightOfWhitespace,
          movesCount: initialMovesCount,
        ),
      );

      await tester.pumpProviderApp(
        PuzzleKeyboardListener(child: Container()),
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );

      await tester.sendKeyDownEvent(
        LogicalKeyboardKey.arrowLeft,
        physicalKey: PhysicalKeyboardKey.arrowLeft,
      );

      verify(
        () => mockPuzzleRepository.updatePuzzle(
          tiles: tiles2x2AboveAndLeftOfWhitespace,
          movesCount: initialMovesCount + 1,
        ),
      ).called(1);
    },
  );

  testWidgets(
    'arrowUp Key event moves tile bottom of whitespace',
    (WidgetTester tester) async {
      when(() => mockPuzzleRepository.get()).thenReturn(
        const Puzzle(
          n: 2,
          tiles: tiles2x2BelowAndLeftOfWhitespace,
          movesCount: initialMovesCount,
        ),
      );

      await tester.pumpProviderApp(
        PuzzleKeyboardListener(child: Container()),
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );

      await tester.sendKeyDownEvent(
        LogicalKeyboardKey.arrowUp,
        physicalKey: PhysicalKeyboardKey.arrowUp,
      );

      verify(
        () => mockPuzzleRepository.updatePuzzle(
          tiles: tiles2x2AboveAndLeftOfWhitespace,
          movesCount: initialMovesCount + 1,
        ),
      ).called(1);
    },
  );

  testWidgets(
    'arrowRight Key event moves tile left of whitespace',
    (WidgetTester tester) async {
      when(() => mockPuzzleRepository.get()).thenReturn(
        const Puzzle(
          n: 2,
          tiles: tiles2x2BelowAndLeftOfWhitespace,
          movesCount: initialMovesCount,
        ),
      );

      await tester.pumpProviderApp(
        PuzzleKeyboardListener(child: Container()),
        overrides: [
          puzzleRepositoryProvider.overrideWithValue(mockPuzzleRepository),
        ],
      );

      await tester.sendKeyDownEvent(
        LogicalKeyboardKey.arrowRight,
        physicalKey: PhysicalKeyboardKey.arrowRight,
      );

      verify(
        () => mockPuzzleRepository.updatePuzzle(
          tiles: tiles2x2BelowAndRightOfWhitespace1,
          movesCount: initialMovesCount + 1,
        ),
      ).called(1);
    },
  );
}
