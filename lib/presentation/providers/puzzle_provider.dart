import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/constants/ui.dart';
import 'package:flutter_puzzle_hack/enums/direction.dart';
import 'package:flutter_puzzle_hack/models/location.dart';
import 'package:flutter_puzzle_hack/models/puzzle.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';

class PuzzleProvider with ChangeNotifier {
  final BuildContext context;

  PuzzleProvider(this.context);

  final int n = 4;

  double get puzzleContainerWidth => MediaQuery.of(context).size.width - UI.screenHPadding * 2;

  Puzzle get puzzle => Puzzle(n: n, tiles: tiles);

  late List<Tile> tiles;

  final Random random = Random();

  List<Tile> get tilesWithoutWhitespace => tiles.where((tile) => !tile.tileIsWhiteSpace).toList();

  List<Tile> generateTiles(double tileWidth) {
    List<Location> _tilesCorrectLocations = Puzzle.generateTileCorrectLocations(n);
    List<Location> _tilesCurrentLocations = List.from(_tilesCorrectLocations);
    _tilesCurrentLocations.shuffle(random);
    // Location.printLocations(_tilesCurrentLocations);
    return List.generate(
      n * n,
      (i) => Tile(
        value: i + 1,
        width: tileWidth,
        correctLocation: _tilesCorrectLocations[i],
        currentLocation: _tilesCurrentLocations[i],
        tileIsWhiteSpace: i == n * n - 1,
      ),
    );
  }

  void swapTilesAndUpdatePuzzle(Tile tile) {
    int movedTileIndex = tiles.indexWhere((_tile) => _tile.value == tile.value);
    int whiteSpaceTileIndex = tiles.indexWhere((_tile) => _tile.tileIsWhiteSpace);
    Tile _movedTile = tiles[movedTileIndex];
    Tile _whiteSpaceTile = tiles[whiteSpaceTileIndex];
    tiles[movedTileIndex] = _movedTile.copyWith(
      currentLocation: _whiteSpaceTile.currentLocation,
    );
    tiles[whiteSpaceTileIndex] = _whiteSpaceTile.copyWith(currentLocation: _movedTile.currentLocation);
    print('Number of correct tiles ${puzzle.getNumberOfCorrectTiles()}');
    print('Is solved: ${puzzle.isSolved}');
    notifyListeners();
  }

  void handleDrag({required Direction direction, required Tile tile}) {
    bool moveTileLeft = direction == Direction.left && puzzle.tileIsRightOfWhiteSpace(tile);
    bool moveTileRight = direction == Direction.right && puzzle.tileIsLeftOfWhiteSpace(tile);
    bool moveTileUp = direction == Direction.up && puzzle.tileIsTopOfWhiteSpace(tile);
    bool moveTileDown = direction == Direction.down && puzzle.tileIsBottomOfWhiteSpace(tile);

    if (moveTileLeft || moveTileRight || moveTileUp || moveTileDown) {
      swapTilesAndUpdatePuzzle(tile);
    }
  }

  List<Tile> _getTilesList({
    required int n,
    required double tileWidth,
    required List<Location> correctLocations,
    required List<Location> currentLocations,
  }) {
    return List.generate(
      n * n,
      (i) => Tile(
        value: i + 1,
        width: tileWidth,
        correctLocation: correctLocations[i],
        currentLocation: currentLocations[i],
        tileIsWhiteSpace: i == n * n - 1,
      ),
    );
  }

  void generate() {
    double _tileContainerWidth = puzzleContainerWidth / n;
    List<Location> _tilesCorrectLocations = Puzzle.generateTileCorrectLocations(n);
    List<Location> _tilesCurrentLocations = List.from(_tilesCorrectLocations);

    tiles = _getTilesList(
      n: n,
      tileWidth: _tileContainerWidth,
      correctLocations: _tilesCorrectLocations,
      currentLocations: _tilesCurrentLocations,
    );

    while (!puzzle.isSolvable() || puzzle.getNumberOfCorrectTiles() != 0) {
      _tilesCurrentLocations.shuffle(random);

      tiles = _getTilesList(
        n: n,
        tileWidth: _tileContainerWidth,
        correctLocations: _tilesCorrectLocations,
        currentLocations: _tilesCurrentLocations,
      );
    }
  }
}
