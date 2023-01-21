import 'dart:developer';
import 'dart:math' hide log;

import 'package:collection/collection.dart';
import 'package:dashtronaut/core/models/location.dart';
import 'package:dashtronaut/core/models/tile.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/puzzle/repositories/tiles_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tilesProvider = NotifierProvider<TilesNotifier, List<Tile>>(
  () => TilesNotifier(),
);

class TilesNotifier extends Notifier<List<Tile>> {
  @override
  List<Tile> build() {
    final n = ref.watch(puzzleSizeProvider);
    return _generate(n).where((tile) => !tile.tileIsWhiteSpace).toList();
  }

  void swapTiles(Tile movedTile) {
    state = [
      for (final tile in state)
        if (tile.currentLocation == movedTile.currentLocation)
          tile.copyWith(currentLocation: whiteSpaceTile.currentLocation)
        else if (tile == whiteSpaceTile)
          tile.copyWith(currentLocation: movedTile.currentLocation)
        else
          tile
    ];
    _updateTilesInStorage();
  }

  void _updateTilesInStorage() {
    ref.watch(tilesRepositoryProvider).set(state);
  }

  /// Random value used in shuffling tiles
  final Random random = Random();

  List<Tile> _generate(int n) {
    var tiles = <Tile>[];
    List<Location> tilesCorrectLocations = generateTileCorrectLocations(n);
    List<Location> tilesCurrentLocations = List.from(tilesCorrectLocations);

    tiles = getTilesFromLocations(
      correctLocations: tilesCorrectLocations,
      currentLocations: tilesCurrentLocations,
    );

    while (!isSolvable(n) || numberOfCorrectTiles != 0) {
      tilesCurrentLocations.shuffle(random);

      tiles = getTilesFromLocations(
        correctLocations: tilesCorrectLocations,
        currentLocations: tilesCurrentLocations,
      );
    }
    return tiles;
  }

  List<Location> generateTileCorrectLocations(int n) {
    List<Location> tilesCorrectLocations = [];
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        Location location = Location(y: i + 1, x: j + 1);
        tilesCorrectLocations.add(location);
      }
    }
    return tilesCorrectLocations;
  }

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
  int get numberOfCorrectTiles {
    var numberOfCorrectTiles = 0;
    for (final tile in state) {
      if (!tile.tileIsWhiteSpace) {
        if (tile.currentLocation == tile.correctLocation) {
          numberOfCorrectTiles++;
        }
      }
    }
    return numberOfCorrectTiles;
  }

  /// Determines if the puzzle is solvable.
  bool isSolvable(int n) {
    final height = state.length ~/ n;
    assert(
      n * height == state.length,
      'tiles must be equal to n * height',
    );
    final inversions = countInversions();

    if (n.isOdd) {
      return inversions.isEven;
    }

    final whitespace = state.singleWhere((tile) => tile.tileIsWhiteSpace);
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
  int countInversions() {
    var count = 0;
    for (var a = 0; a < state.length; a++) {
      final tileA = state[a];
      if (tileA.tileIsWhiteSpace) {
        continue;
      }

      for (var b = a + 1; b < state.length; b++) {
        final tileB = state[b];
        if (_isInversion(tileA, tileB)) {
          count++;
        }
      }
    }
    return count;
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

  /// Get whitespace tile
  Tile get whiteSpaceTile => state.firstWhere((tile) => tile.tileIsWhiteSpace);

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
      state.firstWhereOrNull((tile) => tileIsTopOfWhiteSpace(tile));

  /// Returns the tile at the bottom of the whitespace tile
  Tile? get tileBottomOfWhitespace =>
      state.firstWhereOrNull((tile) => tileIsBottomOfWhiteSpace(tile));

  /// Returns the tile at the right of the whitespace tile
  Tile? get tileRightOfWhitespace =>
      state.firstWhereOrNull((tile) => tileIsRightOfWhiteSpace(tile));

  /// Returns the tile at the left of the whitespace tile
  Tile? get tileLeftOfWhitespace =>
      state.firstWhereOrNull((tile) => tileIsLeftOfWhiteSpace(tile));
}
