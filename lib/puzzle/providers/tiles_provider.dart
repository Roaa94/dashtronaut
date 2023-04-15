import 'dart:math';

import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/puzzle/providers/tiles_state.dart';
import 'package:dashtronaut/puzzle/repositories/puzzle_repository.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tilesProvider = NotifierProvider<TilesNotifier, TilesState>(
  () => TilesNotifier(),
);

class TilesNotifier extends Notifier<TilesState> {
  TilesNotifier({this.random});

  /// Random value used in shuffling tiles
  final Random? random;

  @override
  TilesState build() {
    final existingTiles = puzzleRepository.get()?.tiles;
    return TilesState(
      tiles: existingTiles != null && existingTiles.isNotEmpty
          ? existingTiles
          : generateSolvableTiles(),
    );
  }

  PuzzleStorageRepository get puzzleRepository =>
      ref.watch(puzzleRepositoryProvider);

  void reset() {
    state = TilesState(tiles: generateSolvableTiles());
    puzzleRepository.updateTiles(state.tiles);
  }

  void swapTiles(Tile movedTile) {
    if (!state.isSolved) {
      final newTiles = [
        for (final tile in state.tiles)
          if (tile.currentLocation == movedTile.currentLocation)
            tile.copyWith(currentLocation: state.whiteSpaceTile.currentLocation)
          else if (tile == state.whiteSpaceTile)
            tile.copyWith(currentLocation: movedTile.currentLocation)
          else
            tile
      ];
      state = state.copyWith(tiles: newTiles);
      puzzleRepository.updateTiles(state.tiles);
    }
  }

  void handleTileInteraction(Tile tile, [double? dx, double? dy]) {
    bool tileIsMovable = state.tileIsMovable(tile);
    if (tileIsMovable) {
      if (dx != null) {
        // Horizontal drag event
        bool canMoveRight = dx >= 0 && state.tileIsLeftOfWhiteSpace(tile);
        bool canMoveLeft = dx <= 0 && state.tileIsRightOfWhiteSpace(tile);
        if (canMoveLeft || canMoveRight) {
          swapTiles(tile);
        }
      } else if (dy != null) {
        bool canMoveUp = dy <= 0 && state.tileIsBottomOfWhiteSpace(tile);
        bool canMoveDown = dy >= 0 && state.tileIsTopOfWhiteSpace(tile);
        if (canMoveUp || canMoveDown) {
          swapTiles(tile);
        }
      } else {
        swapTiles(tile);
      }
    }
  }

  /// Handle Keyboard event and move appropriate tile
  void handleKeyboardEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      final physicalKey = event.data.physicalKey;
      Tile? tile;
      if (physicalKey == PhysicalKeyboardKey.arrowDown) {
        tile = state.tileTopOfWhitespace;
      } else if (physicalKey == PhysicalKeyboardKey.arrowUp) {
        tile = state.tileBottomOfWhitespace;
      } else if (physicalKey == PhysicalKeyboardKey.arrowRight) {
        tile = state.tileLeftOfWhitespace;
      } else if (physicalKey == PhysicalKeyboardKey.arrowLeft) {
        tile = state.tileRightOfWhitespace;
      }

      if (tile != null) {
        swapTiles(tile);
      }
    }
  }

  List<Tile> generateSolvableTiles() {
    final n = ref.watch(puzzleSizeProvider);
    var tiles = <Tile>[];
    List<Location> tilesCorrectLocations = generateTileCorrectLocations(n);
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

  /// Determines if the puzzle is solvable.
  bool isSolvable(List<Tile> tiles) {
    final n = ref.watch(puzzleSizeProvider);
    final height = tiles.length ~/ n;
    assert(
      n * height == tiles.length,
      'tiles must be equal to n * height',
    );
    final inversions = countInversions(tiles);

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
