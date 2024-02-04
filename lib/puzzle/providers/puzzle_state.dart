import 'package:collection/collection.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:equatable/equatable.dart';

class PuzzleState extends Equatable {
  final List<Tile> tiles;
  final int movesCount;

  const PuzzleState({
    required this.tiles,
    this.movesCount = 0,
  });

  /// Get whitespace tile
  Tile get whiteSpaceTile => tiles.firstWhere((tile) => tile.tileIsWhiteSpace);

  bool get isSolved => correctTilesCount == tiles.length - 1;

  /// list of [tiles] excluding white space tile
  List<Tile> get withoutWhitespace =>
      tiles.where((tile) => !tile.tileIsWhiteSpace).toList();

  PuzzleState copyWith({List<Tile>? tiles, int? movesCount}) {
    return PuzzleState(
      tiles: tiles ?? this.tiles,
      movesCount: movesCount ?? this.movesCount,
    );
  }

  /// Gets the number of tiles that are currently in their correct position.
  int get correctTilesCount {
    var count = 0;
    for (final tile in tiles) {
      if (!tile.tileIsWhiteSpace) {
        if (tile.currentLocation == tile.correctLocation) {
          count++;
        }
      }
    }
    return count;
  }

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

  @override
  List<Object?> get props => [tiles];
}
