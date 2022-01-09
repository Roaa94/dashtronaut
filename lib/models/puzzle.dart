import 'package:flutter_puzzle_hack/models/location.dart';
import 'package:flutter_puzzle_hack/models/tile.dart';

class Puzzle {
  final int n;
  final List<Tile> tiles;

  Puzzle({
    required this.n,
    required this.tiles,
  }) : assert(n < 10);

  /// Get whitespace tile
  Tile get whiteSpaceTile => tiles.firstWhere((tile) => tile.isWhiteSpaceTile);

  bool isTileMovable(Tile tile) {
    if (tile.isWhiteSpaceTile) {
      return false;
    }
    Location _tileLocation = tile.currentLocation;
    Location _whiteSpaceTileLocation = whiteSpaceTile.currentLocation;
    return _tileLocation.isLocatedAround(_whiteSpaceTileLocation);
  }

  void printData() {
    print('Puzzle dimensions: ${n}x$n');
  }
}
