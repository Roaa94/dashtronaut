import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/models/location.dart';
import 'package:flutter_puzzle_hack/models/puzzle.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';

class PuzzleProvider with ChangeNotifier {
  final int n = 4;

  late Puzzle puzzle;
  final Random random = Random();

  List<Tile> get tilesWithoutWhitespace => puzzle.tiles.where((tile) => !tile.isWhiteSpaceTile).toList();

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
        isWhiteSpaceTile: i == n * n - 1,
      ),
    );
  }

  List<Tile> swapTileWithWhiteSpace(Tile tile) {
    List<Tile> _oldTiles = List.from(puzzle.tiles);
    List<Tile> _updatedTiles = [];
    Location whiteSpaceTileLocation = _oldTiles.firstWhere((tile) => tile.isWhiteSpaceTile).currentLocation;

    // print('Whitespace tile location:');
    // print(whiteSpaceTileLocation.asString);
    for (Tile _tile in _oldTiles) {
      if (_tile.value == tile.value) {
        _updatedTiles.add(
          _tile.copyWith(
            currentLocation: whiteSpaceTileLocation,
          ),
        );
      } else if (_tile.isWhiteSpaceTile) {
        _updatedTiles.add(
          _tile.copyWith(
            currentLocation: tile.currentLocation,
          ),
        );
      } else {
        _updatedTiles.add(_tile);
      }
    }
    return _updatedTiles;
  }

  void swapTilesAndUpdatePuzzle(Tile tile) {
    List<Tile> _updatedTiles = swapTileWithWhiteSpace(tile);
    puzzle = Puzzle(n: n, tiles: _updatedTiles);
    notifyListeners();
  }

  void generate(double puzzleContainerWidth) {
    double _tileContainerWidth = puzzleContainerWidth / n;
    List<Tile> tiles = generateTiles(_tileContainerWidth);
    puzzle = Puzzle(n: n, tiles: tiles);
  }
}
