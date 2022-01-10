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

  Location get _whiteSpaceTileLocation => whiteSpaceTile.currentLocation;

  bool isTileMovable(Tile tile) {
    if (tile.isWhiteSpaceTile) {
      return false;
    }
    Location _tileLocation = tile.currentLocation;
    return _tileLocation.isLocatedAround(_whiteSpaceTileLocation);
  }

  double tileMovableXDistance(Tile tile) {
    /// If the tile is left of OR right of the whitespace tile, then it can only move on the X direction
    if (tile.currentLocation.isLeftOf(_whiteSpaceTileLocation)) {
      /// And it can only move a distance equal to the tile width in the +x direction
      return tile.width;
    }
    if (tile.currentLocation.isRightOf(_whiteSpaceTileLocation)) {
      /// And it can only move a distance equal to the tile width in the -x direction
      return -tile.width;
    }
    return 0;
  }

  double tileMovableYDistance(Tile tile) {
    /// If the tile is top of OR bottom of the whitespace tile, then it can only move on the Y direction
    if (tile.currentLocation.isTopOf(_whiteSpaceTileLocation)) {
      /// And it can only move a distance equal to the tile width in the -y direction
      return -tile.width;
    }
    if (tile.currentLocation.isBottomOf(_whiteSpaceTileLocation)) {
      /// And it can only move a distance equal to the tile width in the +y direction
      return tile.width;
    }
    return 0;
  }

  String? getTileLocationText(Tile tile) {
    return tile.currentLocation.isLeftOf(_whiteSpaceTileLocation)
        ? 'Left'
        : tile.currentLocation.isTopOf(_whiteSpaceTileLocation)
            ? 'Top'
            : tile.currentLocation.isBottomOf(_whiteSpaceTileLocation)
                ? 'Bottom'
                : tile.currentLocation.isRightOf(_whiteSpaceTileLocation)
                    ? 'Right'
                    : null;
  }

  static List<Location> generateTileCorrectLocations(int _n) {
    List<Location> _tilesCorrectLocations = [];
    for (int i = 0; i < _n; i++) {
      for (int j = 0; j < _n; j++) {
        Location _location = Location(y: i + 1, x: j + 1);
        // print(_location.asString);
        _tilesCorrectLocations.add(_location);
      }
    }
    return _tilesCorrectLocations;
  }

  void printData() {
    print('Puzzle dimensions: ${n}x$n');
  }
}
