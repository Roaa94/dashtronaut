import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_puzzle_hack/constants/ui.dart';
import 'package:flutter_puzzle_hack/models/location.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/models/puzzle.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/layout/screen_type_helper.dart';

/// PuzzleProvider handles:
/// Parameters
/// 1. Puzzle size [n] of type [int] (final size = n x n)
/// 2. Puzzle tiles [tiles] [List<tile>]
/// 3. Puzzle container width [double]
///    Calculated from context and used in the [generate()] function to give values to tile width based on it
/// 4. Active tile value [int] value from 1 => n*n
///
/// Getters:
/// 1. [puzzle] => based on puzzle size and tiles [Puzzle]
/// 2. [activeTile] => from [activeTileValue]
/// 3. [tilesWithoutWhitespace] => list of [tiles] excluding white space tile
/// 4. [tilesAroundWhiteSpace] => list of [tiles] top of || bottom of || left of || right of white space tile
///
/// Methods:
/// 1. [generate] generates solvable puzzle tiles and sets initial values of [activeTileValue]
/// 2. [swapTilesAndUpdatePuzzle] called when tile movement is released by
///    the user (Drag End) to notify tile rebuild with new locations
class PuzzleProvider with ChangeNotifier {
  final BuildContext context;

  PuzzleProvider(this.context);

  /// One dimensional size of the puzzle => size = n x n
  int n = Puzzle.supportedPuzzleSizes[0];

  void resetPuzzleSize(int size) {
    assert(Puzzle.supportedPuzzleSizes.contains(size));
    n = size;
    generate();
  }

  /// Random value used in shuffling tiles
  final Random random = Random();

  static const Duration dragAnimationDuration = Duration(milliseconds: 0);
  static const Duration snapAnimationDuration = Duration(milliseconds: 150);

  ScreenType get screenType => ScreenTypeHelper(context).type;

  /// Puzzle outer container width
  double get puzzleContainerWidth {
    switch (screenType) {
      case ScreenType.xSmall:
      case ScreenType.small:
        return MediaQuery.of(context).size.width - UI.screenHPadding * 2;
      case ScreenType.medium:
        if (MediaQuery.of(context).orientation == Orientation.landscape) {
          return MediaQuery.of(context).size.flipped.width - UI.screenHPadding * 2;
        } else {
          return 500;
        }
      case ScreenType.large:
        return 500;
    }
  }

  double get distanceOutsidePuzzle {
    double screenHeight = MediaQuery.of(context).orientation == Orientation.landscape && !kIsWeb
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;
    return ((screenHeight - puzzleContainerWidth) / 2) + puzzleContainerWidth;
  }

  /// List of tiles of the puzzle
  late List<Tile> tiles;

  /// Map of {tileValue [int]: tilePosition [Position]} for dragged tiles
  late Map<int, Position> draggedTilePositions;

  /// Map of {tileValue [int]: tileDragDurations [Duration]} for dragging tiles
  /// This is needed because there are 2 type of animation when dragging a tile
  /// 1. When dragging is in progress (drag update) duration should be 0 to prevent delay between input movement
  /// 2. When dragging is released (drag end) duration should be > 0 to show smooth snapping animation
  late Map<int, Duration> tileDragDurations;

  /// list of [tiles] excluding white space tile
  List<Tile> get tilesWithoutWhitespace => tiles.where((tile) => !tile.tileIsWhiteSpace).toList();

  /// list of [tiles] top of || bottom of || left of || right of white space tile
  List<Tile> get tilesAroundWhiteSpace => tiles.where((tile) => puzzle.tileIsMovable(tile)).toList();

  /// Active tile value (for keyboard on web/desktop)
  late int activeTileValue;

  /// Active tile [Tile] from [activeTileValue]
  Tile get activeTile => tiles.singleWhere((tile) => tile.value == activeTileValue);

  /// Getter for puzzle object
  Puzzle get puzzle => Puzzle(n: n, tiles: tiles);

  /// Return a [Tile] from its value
  Tile getTileFromValue(int tileValue) => tiles.singleWhere((tile) => tile.value == tileValue);

  /// Stores the tile values already visited by pressing keyboard tab key
  /// for the purpose of not selecting them again until all selectable tiles (all tiles around the white space) are visited
  /// Cleared once its length == [tilesAroundWhiteSpace]'s length
  List<int> _visitedActiveTileValues = [];

  /// Selects the next selectable tile with the keyboard tab key
  void _setNextActiveTile() {
    /// If all tiles around the white space were visited, clear the
    /// [_visitedActiveTileValues] list to allow looping over them again
    if (_visitedActiveTileValues.length >= tilesAroundWhiteSpace.length) {
      // print('All tiles were visited, clearing...');
      _visitedActiveTileValues.clear();
    }
    for (final tile in tilesAroundWhiteSpace) {
      if (tile.value != activeTileValue && !_visitedActiveTileValues.contains(tile.value)) {
        activeTileValue = tile.value;
        _visitedActiveTileValues.add(activeTileValue);
        notifyListeners();
        break;
      }
    }
  }

  void handleKeyboardEvent(RawKeyEvent event) {
    if (event.isKeyPressed(LogicalKeyboardKey.tab)) {
      _setNextActiveTile();
    }
    if (event.isKeyPressed(LogicalKeyboardKey.arrowUp) ||
        event.isKeyPressed(LogicalKeyboardKey.arrowDown) ||
        event.isKeyPressed(LogicalKeyboardKey.arrowLeft) ||
        event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
      swapTilesAndUpdatePuzzle(activeTile);
    }
  }

  /// Change the dragging [Position] of a tile
  void setDraggedTilePosition(int _tileValue, Position _tilePosition) {
    draggedTilePositions[_tileValue] = _tilePosition;
    notifyListeners();
  }

  /// Action that switches the [Location]'s => [Position]'s of the tile
  /// dragged by the user & the whitespace tile
  /// This causes the [Tile.position] getter to get the correct position based on new [Location]'s
  void swapTilesAndUpdatePuzzle(Tile tile) {
    int movedTileIndex = tiles.indexWhere((_tile) => _tile.value == tile.value);
    int whiteSpaceTileIndex = tiles.indexWhere((_tile) => _tile.tileIsWhiteSpace);
    // Store instances of the moved tile and the white space tile before changing their locations
    Tile _movedTile = tiles[movedTileIndex];
    Tile _whiteSpaceTile = tiles[whiteSpaceTileIndex];

    tileDragDurations[_movedTile.value] = snapAnimationDuration;
    tiles[movedTileIndex] = tiles[movedTileIndex].copyWith(currentLocation: _whiteSpaceTile.currentLocation);
    draggedTilePositions[_movedTile.value] = tiles[movedTileIndex].position;

    tiles[whiteSpaceTileIndex] = _whiteSpaceTile.copyWith(currentLocation: _movedTile.currentLocation);
    draggedTilePositions[_whiteSpaceTile.value] = tiles[whiteSpaceTileIndex].position;

    print('Number of correct tiles ${puzzle.getNumberOfCorrectTiles()} | Is solved: ${puzzle.isSolved}');
    // If the above switch in positions causes the `activeTile` to become not around
    // the white space tile (not movable) reset the value of the `activeTileValue` to the first movable tile's value
    if (!puzzle.tileIsMovable(activeTile)) {
      activeTileValue = tilesAroundWhiteSpace[0].value;
      _visitedActiveTileValues = [activeTileValue];
    }
    Future.delayed(snapAnimationDuration, () {
      tileDragDurations[_movedTile.value] = dragAnimationDuration;
    });
    notifyListeners();
  }

  /// Generates tiles with shuffle
  void generate() {
    double _tileContainerWidth = puzzleContainerWidth / n;
    List<Location> _tilesCorrectLocations = Puzzle.generateTileCorrectLocations(n);
    List<Location> _tilesCurrentLocations = List.from(_tilesCorrectLocations);

    tiles = Puzzle.getTilesFromLocations(
      n: n,
      tileWidth: _tileContainerWidth,
      correctLocations: _tilesCorrectLocations,
      currentLocations: _tilesCurrentLocations,
    );

    while (!puzzle.isSolvable() || puzzle.getNumberOfCorrectTiles() != 0) {
      _tilesCurrentLocations.shuffle(random);

      tiles = Puzzle.getTilesFromLocations(
        n: n,
        tileWidth: _tileContainerWidth,
        correctLocations: _tilesCorrectLocations,
        currentLocations: _tilesCurrentLocations,
      );
    }
    // Set initial value of the active tile
    activeTileValue = tilesAroundWhiteSpace[0].value;
    // Add the active tile to the visited tiles list
    _visitedActiveTileValues = [activeTileValue];
    // Set initial values of dragged tiles positions and durations
    draggedTilePositions = {for (final tile in tiles) tile.value: tile.position};
    tileDragDurations = {for (final tile in tiles) tile.value: dragAnimationDuration};
    notifyListeners();
  }
}
