import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/constants/ui.dart';
import 'package:flutter_puzzle_hack/enums/destination.dart';
import 'package:flutter_puzzle_hack/models/direction.dart';
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

  late List<Tile> tiles;

  final Random random = Random();

  List<Tile> get tilesWithoutWhitespace => tiles.where((tile) => !tile.tileIsWhiteSpace).toList();

  List<Tile> generateTiles(double tileWidth) {
    List<Location> _tilesCorrectLocations = Puzzle.generateTileCorrectLocations(n);
    List<Location> _tilesCurrentLocations = List.from(_tilesCorrectLocations);
    _tilesCurrentLocations.shuffle(random);
    // Location.printLocations(_tilesCurrentLocations);
    return _getTilesList(
      n: n,
      tileWidth: tileWidth,
      correctLocations: _tilesCorrectLocations,
      currentLocations: _tilesCurrentLocations,
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

  bool _canSwapTiles({required Destination destination, required Tile tile}) {
    bool moveTileLeft = destination == Destination.left && puzzle.tileIsRightOfWhiteSpace(tile);
    bool moveTileRight = destination == Destination.right && puzzle.tileIsLeftOfWhiteSpace(tile);
    bool moveTileUp = destination == Destination.top && puzzle.tileIsBottomOfWhiteSpace(tile);
    bool moveTileDown = destination == Destination.bottom && puzzle.tileIsTopOfWhiteSpace(tile);

    return moveTileLeft || moveTileRight || moveTileUp || moveTileDown;
  }

  void handleDragEnd({required Direction direction, required Tile tile}) {
    bool canSwapTiles = _canSwapTiles(destination: direction.destination, tile: tile);

    if (canSwapTiles) {
      swapTilesAndUpdatePuzzle(tile);
    }
  }

  Position? getPositionFromDragUpdate({
    required Direction direction,
    required double distance,
    required Tile tile,
    required Position currentPosition,
  }) {
    Position? _newPosition;
    if (direction.isHorizontal && puzzle.tileIsMovableOnXAxis(tile)) {
      _newPosition = Position(left: currentPosition.left + distance, top: currentPosition.top);
    } else if (direction.isVertical && puzzle.tileIsMovableOnYAxis(tile)) {
      _newPosition = Position(left: currentPosition.left, top: currentPosition.top + distance);
    }
    if (_newPosition != null) {
      // print('New Position: ${_newPosition.asString}');
      return _newPosition;
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
