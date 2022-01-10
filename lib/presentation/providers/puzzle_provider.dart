import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/models/location.dart';
import 'package:flutter_puzzle_hack/models/puzzle.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';

class PuzzleProvider with ChangeNotifier {
  final int n = 3;

  late Puzzle puzzle;
  final Random random = Random();

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

  void generate(double puzzleContainerWidth) {
    double _tileContainerWidth = puzzleContainerWidth / n;
    List<Tile> tiles = generateTiles(_tileContainerWidth);
    puzzle = Puzzle(n: n, tiles: tiles);
  }
}
