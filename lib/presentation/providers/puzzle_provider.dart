import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/enums/direction.dart';
import 'package:flutter_puzzle_hack/models/location.dart';
import 'package:flutter_puzzle_hack/models/puzzle.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';

class PuzzleProvider with ChangeNotifier {
  final int n = 3;

  Puzzle get puzzle => Puzzle(n: n, tiles: tiles);

  late List<Tile> tiles;
  late Map<int, StreamController<Tile>> tileStreamControllers;

  final Random random = Random();

  List<Tile> get tilesWithoutWhitespace => tiles.where((tile) => !tile.isWhiteSpaceTile).toList();

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

  void swapTilesAndUpdatePuzzle(Tile tile) {
    int movedTileIndex = tiles.indexWhere((_tile) => _tile.value == tile.value);
    int whiteSpaceTileIndex = tiles.indexWhere((_tile) => _tile.isWhiteSpaceTile);
    Tile _movedTile = tiles[movedTileIndex];
    Tile _whiteSpaceTile = tiles[whiteSpaceTileIndex];
    tiles[movedTileIndex] = _movedTile.copyWith(
      currentLocation: _whiteSpaceTile.currentLocation,
    );
    tileStreamControllers[tiles[movedTileIndex].value]!.add(tiles[movedTileIndex]);
    tiles[whiteSpaceTileIndex] = _whiteSpaceTile.copyWith(currentLocation: _movedTile.currentLocation);
    tileStreamControllers[tiles[whiteSpaceTileIndex].value]!.add(tiles[whiteSpaceTileIndex]);
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

  void generate(double puzzleContainerWidth) {
    double _tileContainerWidth = puzzleContainerWidth / n;
    tiles = generateTiles(_tileContainerWidth);
    tileStreamControllers = <int, StreamController<Tile>>{
      for (var tile in tiles) tile.value: StreamController<Tile>(),
    };
  }
}
