import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/constants/ui.dart';
import 'package:flutter_puzzle_hack/models/location.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';
import 'package:flutter_puzzle_hack/models/tiles_data.dart';

class Puzzle {
  final BuildContext context;
  final int dimension;

  Puzzle({
    required this.context,
    required this.dimension,
  }) : assert(dimension < 10);

  double get containerWidth => MediaQuery.of(context).size.width - UI.screenHPadding * 2;

  double get _tileContainerWidth => containerWidth / dimension;

  int get dimensions => dimension * dimension;

  int get tileCount => dimensions - 1;

  List<Position> get _tilesPositions => _tilesData.positions;

  List<Location> get _tilesLocations => _tilesData.locations;

  TilesData get _tilesData {
    List<Position> __tilesPositions = [];
    List<Location> __tileLocations = [];

    // If dimension is 3 (3x3)
    // i = 0, 1, 2
    for (int i = 0; i < dimension; i++) {
      for (int j = 0; j < dimension; j++) {
        __tilesPositions.add(Position(left: j * _tileContainerWidth, top: i * _tileContainerWidth));
        __tileLocations.add(Location(x: i + 1, y: j + 1));
      }
    }
    assert(__tilesPositions.length == tileCount + 1);
    assert(__tileLocations.length == tileCount + 1);
    return TilesData(
      positions: __tilesPositions,
      locations: __tileLocations,
    );
  }

  List<Tile> get tiles {
    return List.generate(
      tileCount,
      (i) => Tile(
        value: i + 1,
        width: _tileContainerWidth,
        position: _tilesPositions[i],
        location: _tilesLocations[i],
        isMovable: false,
      ),
    );
  }

  Tile get whiteSpaceTile => Tile(
        value: 0,
        width: _tileContainerWidth,
        position: _tilesPositions[tileCount + 1],
        location: _tilesLocations[tileCount + 1],
      );

  void printData() {
    print('Puzzle dimensions: ${dimension}x$dimension');
    // print('Puzzle Container Width: $containerWidth');
    // print('Puzzle Tile Container Width: $_tileContainerWidth');
  }
}
