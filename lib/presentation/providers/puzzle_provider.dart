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

  Tile get activeTile => tiles.singleWhere((tile) => tile.isActive);

  void _setIsActiveTile(Tile _tile) {
    int currentActiveTileIndex = tiles.indexWhere((tile) => tile.value == activeTile.value);
    int newActiveTileIndex = tiles.indexWhere((tile) => tile.value == _tile.value);
    if (newActiveTileIndex > 0 && currentActiveTileIndex > 0) {
      tiles[currentActiveTileIndex].isActive = false;
      tiles[newActiveTileIndex].isActive = true;
      notifyListeners();
      print('Active tile value: ${activeTile.value}');
    }
  }

  void setNextActiveTile() {
    if (_visitedActiveTileValues.length == puzzle.tilesAroundWhitespace.length) {
      print('All tiles were visited, clearing...');
      _visitedActiveTileValues.clear();
    }
    for (final tile in puzzle.tilesAroundWhitespace) {
      if (tile.value != activeTile.value) {
        _setIsActiveTile(tile);
        break;
      }
    }
  }

  late List<Tile> tiles;

  final Random random = Random();

  List<Tile> get tilesWithoutWhitespace => tiles.where((tile) => !tile.tileIsWhiteSpace).toList();

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

      List<Tile> _tiles = _getTilesList(
        n: n,
        tileWidth: _tileContainerWidth,
        correctLocations: _tilesCorrectLocations,
        currentLocations: _tilesCurrentLocations,
      );
      Tile _activeTile = Puzzle(n: n, tiles: _tiles).tilesAroundWhitespace[0];
      _tiles[_tiles.indexWhere((tile) => tile.value == _activeTile.value)].isActive = true;
      _visitedActiveTileValues.add(_activeTile.value);
      tiles = _tiles;
    }
  }
}
