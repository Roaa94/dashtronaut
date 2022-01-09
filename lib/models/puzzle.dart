import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/constants/ui.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';

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

  List<double> get _tilesLeftPositions => _tilesPositions['left']!;

  List<double> get _tilesTopPositions => _tilesPositions['top']!;

  Map<String, List<double>> get _tilesPositions {
    List<double> __tilesLeftPositions = [];
    List<double> __tilesTopPositions = [];
    // If dimension is 3 (3x3)
    // i = 0, 1, 2
    for (int i = 0; i < dimension; i++) {
      for (int j = 0; j < dimension; j++) {
        __tilesLeftPositions.add(j * _tileContainerWidth);
        __tilesTopPositions.add(i * _tileContainerWidth);
      }
    }
    return {
      'left': __tilesLeftPositions,
      'top': __tilesTopPositions,
    };
  }

  List<Tile> get tiles {
    return List.generate(
      tileCount,
      (i) => Tile(
        value: i + 1,
        width: _tileContainerWidth,
        position: Position(
          top: _tilesTopPositions[i],
          left: _tilesLeftPositions[i],
        ),
      ),
    );
  }

  void printData() {
    print('Puzzle dimensions: ${dimension}x$dimension');
    // print('Puzzle Container Width: $containerWidth');
    print('Puzzle Tile Container Width: $_tileContainerWidth');
    print('Puzzle tiles left positions array: $_tilesLeftPositions');
    print('Puzzle tiles top positions array: $_tilesTopPositions');
  }
}
