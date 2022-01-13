import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/constants/ui.dart';
import 'package:flutter_puzzle_hack/models/location.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/models/puzzle.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';

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
/// 2. [activeTile] => from activeTileValue
/// 3. [tilesWithoutWhitespace] => list of [tiles] excluding white space tile
/// 4. [tilesAroundWhiteSpace] => list of [tiles] top of || bottom of || left of || right of white space tile
class PuzzleProvider with ChangeNotifier {
  final BuildContext context;

  PuzzleProvider(this.context);

  /// One dimensional size of the puzzle => size = n x n
  final int n = 3;

  final Random random = Random();

  double get puzzleContainerWidth => MediaQuery.of(context).size.width - UI.screenHPadding * 2;

  late List<Tile> tiles;

  /// list of [tiles] excluding white space tile
  List<Tile> get tilesWithoutWhitespace => tiles.where((tile) => !tile.tileIsWhiteSpace).toList();

  /// list of [tiles] top of || bottom of || left of || right of white space tile
  List<Tile> get tilesAroundWhiteSpace => tiles.where((tile) => puzzle.tileIsMovable(tile)).toList();

  /// Active tile value (for keyboard on web/desktop)
  late int activeTileValue;

  /// Active tile [Tile] from [activeTileValue]
  Tile get activeTile => tiles.singleWhere((tile) => tile.value == activeTileValue);

  Puzzle get puzzle => Puzzle(n: n, tiles: tiles);

  /// Stores the tile values already visited by pressing keyboard tab key
  /// for the purpose of not selecting them again until all selectable tiles (all tiles around the white space) are visited
  /// Cleared once its length == [tilesAroundWhiteSpace]'s length
  List<int> _visitedActiveTileValues = [];

  /// Selects the next selectable tile with the keyboard tab key
  void setNextActiveTile() {
    /// If all tiles around the white space were visited, clear the
    /// [_visitedActiveTileValues] list to allow looping over them again
    if (_visitedActiveTileValues.length == tilesAroundWhiteSpace.length) {
      print('All tiles were visited, clearing...');
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

  /// Action that switches the [Location]'s => [Position]'s of the tile
  /// dragged by the user & the whitespace tile
  /// This causes the [Tile.position] getter to get the correct position based on new [Location]'s
  Position swapTilesAndUpdatePuzzle(Tile tile) {
    int movedTileIndex = tiles.indexWhere((_tile) => _tile.value == tile.value);
    int whiteSpaceTileIndex = tiles.indexWhere((_tile) => _tile.tileIsWhiteSpace);
    // Store instances of the moved tile and the white space tile before changing their locations
    Tile _movedTile = tiles[movedTileIndex];
    Tile _whiteSpaceTile = tiles[whiteSpaceTileIndex];
    tiles[movedTileIndex] = tiles[movedTileIndex].copyWith(
      currentLocation: _whiteSpaceTile.currentLocation,
    );
    tiles[whiteSpaceTileIndex] = _whiteSpaceTile.copyWith(currentLocation: _movedTile.currentLocation);
    print('Number of correct tiles ${puzzle.getNumberOfCorrectTiles()} | Is solved: ${puzzle.isSolved}');
    // If the above switch in positions causes the `activeTile` to become not around
    // the white space tile (not movable) reset the value of the `activeTileValue` to the first movable tile's value
    if (!puzzle.tileIsMovable(activeTile)) {
      activeTileValue = tilesAroundWhiteSpace[0].value;
    }
    notifyListeners();
    return tiles[movedTileIndex].position;
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
  }
}
