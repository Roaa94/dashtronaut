import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/constants/ui.dart';
import 'package:flutter_puzzle_hack/models/location.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/models/puzzle.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';

class PuzzleProvider with ChangeNotifier {
  final BuildContext context;

  PuzzleProvider(this.context);

  final int n = 3;

  double get puzzleContainerWidth => MediaQuery.of(context).size.width - UI.screenHPadding * 2;

  Puzzle get puzzle => Puzzle(n: n, tiles: tiles);

  final List<int> _visitedActiveTileValues = [];

  late int activeTileValue;

  Tile get activeTile => tiles.singleWhere((tile) => tile.value == activeTileValue);

  void setNextActiveTile() {
    if (_visitedActiveTileValues.length == puzzle.tilesAroundWhitespace.length) {
      print('All tiles were visited, clearing...');
      _visitedActiveTileValues.clear();
    }
    for (final tile in tilesAroundWhiteSpace) {
      if (tile.value != activeTileValue) {
        activeTileValue = tile.value;
        notifyListeners();
        break;
      }
    }
  }

  late List<Tile> tiles;

  final Random random = Random();

  List<Tile> get tilesWithoutWhitespace => tiles.where((tile) => !tile.tileIsWhiteSpace).toList();

  List<Tile> get tilesAroundWhiteSpace => puzzle.tilesAroundWhitespace;

  Position swapTilesAndUpdatePuzzle(Tile tile) {
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
    return tiles[movedTileIndex].position;
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
      Tile _activeTile = puzzle.tilesAroundWhitespace[0];
      activeTileValue = _activeTile.value;
      _visitedActiveTileValues.add(activeTileValue);
    }
  }
}
