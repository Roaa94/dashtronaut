import 'dart:math';

import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final slidePuzzleLogicProvider = Provider.family<SlidePuzzleLogic, int>(
  (ref, size) => SlidePuzzleLogic(size),
);

class SlidePuzzleLogic {
  SlidePuzzleLogic(this.size);

  final int size;

  /// Given a puzzle size, generate a list of tile [Location]s
  ///
  /// For example, for a 3x3 puzzle, generated correct locations will be:
  /// | 1,1 | 2,1 | 3, 1 |
  /// | 1,2 | 2,2 | 3, 2 |
  /// | 1,3 | 2,3 | 3, 3 |
  List<Tile> generateSolvableTiles([Random? random]) {
    var tiles = <Tile>[];
    List<Location> tilesCorrectLocations = generateTileCorrectLocations();
    List<Location> tilesCurrentLocations = List.from(tilesCorrectLocations);

    tiles = getTilesFromLocations(
      correctLocations: tilesCorrectLocations,
      currentLocations: tilesCurrentLocations,
    );

    while (!isSolvable(tiles) || getNumberOfCorrectTiles(tiles) != 0) {
      tilesCurrentLocations.shuffle(random);

      tiles = getTilesFromLocations(
        correctLocations: tilesCorrectLocations,
        currentLocations: tilesCurrentLocations,
      );
    }
    return tiles;
  }

  List<Location> generateTileCorrectLocations() {
    List<Location> tilesCorrectLocations = [];
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        Location location = Location(y: i + 1, x: j + 1);
        tilesCorrectLocations.add(location);
      }
    }
    return tilesCorrectLocations;
  }

  /// Returns a list of tiles from current & correct locations lists
  List<Tile> getTilesFromLocations({
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

  /// Gets the number of tiles that are currently in their correct position.
  int getNumberOfCorrectTiles(List<Tile> tiles) {
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

  /// Determines if the tile combination is solvable.
  bool isSolvable(List<Tile> tiles) {
    final height = tiles.length ~/ size;
    assert(
      size * height == tiles.length,
      'tiles must be equal to n * height',
    );
    final inversions = countInversions(tiles);

    if (size.isOdd) {
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

  /// Gives the number of inversions in a puzzle given its tile arrangement.
  ///
  /// An inversion is when a tile of a lower value is in a greater position than
  /// a tile of a higher value.
  int countInversions(List<Tile> tiles) {
    var count = 0;
    for (var a = 0; a < tiles.length; a++) {
      final tileA = tiles[a];
      if (tileA.tileIsWhiteSpace) {
        continue;
      }

      for (var b = a + 1; b < tiles.length; b++) {
        final tileB = tiles[b];
        if (isInversion(tileA, tileB)) {
          count++;
        }
      }
    }
    return count;
  }

  /// Determines if the two tiles are inverted.
  bool isInversion(Tile a, Tile b) {
    if (!b.tileIsWhiteSpace && a.value != b.value) {
      if (b.value < a.value) {
        return b.currentLocation.compareTo(a.currentLocation) > 0;
      } else {
        return a.currentLocation.compareTo(b.currentLocation) > 0;
      }
    }
    return false;
  }
}
