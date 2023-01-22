import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

/// Model for a Puzzle
class Puzzle extends Equatable {
  final int n;
  final List<Tile> tiles;
  final int movesCount;

  const Puzzle({
    required this.n,
    required this.tiles,
    this.movesCount = 0,
  });

  /// Get whitespace tile
  Tile get whiteSpaceTile => tiles.firstWhere((tile) => tile.tileIsWhiteSpace);

  /// Check if a [Tile] is movable
  ///
  /// A tile if movable if it's not a whitespace tile
  /// and if it's located around the whitespace tile
  /// (top of, bottom of, right of, or left of)
  bool tileIsMovable(Tile tile) {
    if (tile.tileIsWhiteSpace) {
      return false;
    }
    return tile.currentLocation.isLocatedAround(whiteSpaceTile.currentLocation);
  }

  /// Check if a tile is left of the whitespace tile
  bool tileIsLeftOfWhiteSpace(Tile tile) {
    return tile.currentLocation.isLeftOf(whiteSpaceTile.currentLocation);
  }

  /// Check if a tile is right of the whitespace tile
  bool tileIsRightOfWhiteSpace(Tile tile) {
    return tile.currentLocation.isRightOf(whiteSpaceTile.currentLocation);
  }

  /// Check if a tile is top of the whitespace tile
  bool tileIsTopOfWhiteSpace(Tile tile) {
    return tile.currentLocation.isTopOf(whiteSpaceTile.currentLocation);
  }

  /// Check if a tile is bottom of the whitespace tile
  bool tileIsBottomOfWhiteSpace(Tile tile) {
    return tile.currentLocation.isBottomOf(whiteSpaceTile.currentLocation);
  }

  /// Returns the tile at the top of the whitespace tile
  Tile? get tileTopOfWhitespace =>
      tiles.firstWhereOrNull((tile) => tileIsTopOfWhiteSpace(tile));

  /// Returns the tile at the bottom of the whitespace tile
  Tile? get tileBottomOfWhitespace =>
      tiles.firstWhereOrNull((tile) => tileIsBottomOfWhiteSpace(tile));

  /// Returns the tile at the right of the whitespace tile
  Tile? get tileRightOfWhitespace =>
      tiles.firstWhereOrNull((tile) => tileIsRightOfWhiteSpace(tile));

  /// Returns the tile at the left of the whitespace tile
  Tile? get tileLeftOfWhitespace =>
      tiles.firstWhereOrNull((tile) => tileIsLeftOfWhiteSpace(tile));

  /// Given a puzzle size, generate a list of tile [Location]s
  ///
  /// For example, for a 3x3 puzzle, generated correct locations will be:
  /// | 1,1 | 2,1 | 3, 1 |
  /// | 1,2 | 2,2 | 3, 2 |
  /// | 1,3 | 2,3 | 3, 3 |
  static List<Location> generateTileCorrectLocations(int n) {
    List<Location> tilesCorrectLocations = [];
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        Location location = Location(y: i + 1, x: j + 1);
        tilesCorrectLocations.add(location);
      }
    }
    return tilesCorrectLocations;
  }

  /// Returns a list of tiles from current & correct locations lists
  static List<Tile> getTilesFromLocations({
    required List<Location> correctLocations,
    required List<Location> currentLocations,
  }) {
    return List.generate(
      correctLocations.length,
      (i) => Tile(
        value: i + 1,
        correctLocation: correctLocations[i],
        currentLocation: currentLocations[i],
        tileIsWhiteSpace: i == correctLocations.length - 1,
      ),
    );
  }

  /// Determines if the two tiles are inverted.
  bool _isInversion(Tile a, Tile b) {
    if (!b.tileIsWhiteSpace && a.value != b.value) {
      if (b.value < a.value) {
        return b.currentLocation.compareTo(a.currentLocation) > 0;
      } else {
        return a.currentLocation.compareTo(b.currentLocation) > 0;
      }
    }
    return false;
  }

  /// Gives the number of inversions in a puzzle given its tile arrangement.
  ///
  /// An inversion is when a tile of a lower value is in a greater position than
  /// a tile of a higher value.
  int countInversions() {
    var count = 0;
    for (var a = 0; a < tiles.length; a++) {
      final tileA = tiles[a];
      if (tileA.tileIsWhiteSpace) {
        continue;
      }

      for (var b = a + 1; b < tiles.length; b++) {
        final tileB = tiles[b];
        if (_isInversion(tileA, tileB)) {
          count++;
        }
      }
    }
    return count;
  }

  /// Determines if the puzzle is solvable.
  bool isSolvable() {
    final height = tiles.length ~/ n;
    assert(
      n * height == tiles.length,
      'tiles must be equal to n * height',
    );
    final inversions = countInversions();

    if (n.isOdd) {
      return inversions.isEven;
    }

    final whitespace = tiles.singleWhere((tile) => tile.tileIsWhiteSpace);
    final whitespaceRow = whitespace.currentLocation.y;

    if (((height - whitespaceRow) + 1).isOdd) {
      return inversions.isEven;
    } else {
      return inversions.isOdd;
    }
  }

  bool get isSolved => getNumberOfCorrectTiles() == tiles.length - 1;

  /// Gets the number of tiles that are currently in their correct position.
  int getNumberOfCorrectTiles() {
    var numberOfCorrectTiles = 0;
    for (final tile in tiles) {
      if (!tile.tileIsWhiteSpace) {
        if (tile.currentLocation == tile.correctLocation) {
          numberOfCorrectTiles++;
        }
      }
    }
    return numberOfCorrectTiles;
  }

  factory Puzzle.fromJson(Map<String, dynamic> json) {
    return Puzzle(
      tiles: json['tiles'] == null
          ? []
          : List<Tile>.from(json['tiles'].map((x) => Tile.fromJson(x))),
      movesCount: json['movesCount'] ?? 0,
      n: json['n'],
    );
  }

  Puzzle copyWith({
    List<Tile>? tiles,
    int? n,
    int? movesCount,
  }) {
    return Puzzle(
      n: n ?? this.n,
      tiles: tiles ?? this.tiles,
      movesCount: movesCount ?? this.movesCount,
    );
  }

  Map<String, dynamic> toJson() => {
        'tiles': List<dynamic>.from(tiles.map((x) => x.toJson())),
        'movesCount': movesCount,
        'n': n,
      };

  @override
  List<Object?> get props => [n, movesCount, tiles];
}
