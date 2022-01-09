import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/constants/ui.dart';

class Puzzle {
  final BuildContext context;
  final int dimension;

  Puzzle({
    required this.context,
    required this.dimension,
  }) : assert(dimension < 10);

  double get containerWidth => MediaQuery.of(context).size.width - UI.screenHPadding * 2;

  double get tileContainerWidth => containerWidth / dimension;

  int get dimensions => dimension * dimension;

  int get tileCount => dimensions - 1;

  List<double> get tilesLeftPositions => tilesPositions['left']!;

  List<double> get tilesTopPositions => tilesPositions['top']!;

  Map<String, List<double>> get tilesPositions {
    List<double> _tilesLeftPositions = [];
    List<double> _tilesTopPositions = [];
    // If dimension is 3 (3x3)
    // i = 0, 1, 2
    for (int i = 0; i < dimension; i++) {
      for (int j = 0; j < dimension; j++) {
        _tilesLeftPositions.add(j * tileContainerWidth);
        _tilesTopPositions.add(i * tileContainerWidth);
      }
    }
    assert(_tilesLeftPositions.length == dimensions);
    assert(_tilesTopPositions.length == dimensions);
    return {
      'left': _tilesLeftPositions,
      'top': _tilesTopPositions,
    };
  }

  void printData() {
    print('Puzzle dimensions: ${dimension}x$dimension');
    // print('Puzzle Container Width: $containerWidth');
    print('Puzzle Tile Container Width: $tileContainerWidth');
    print('Puzzle tiles left positions array: $tilesLeftPositions');
    print('Puzzle tiles top positions array: $tilesTopPositions');
  }
}
