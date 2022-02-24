import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:Dashtronaut/models/location.dart';
import 'package:Dashtronaut/models/position.dart';
import 'package:Dashtronaut/models/puzzle.dart';
import 'package:Dashtronaut/models/tile.dart';
import 'package:Dashtronaut/services/service_locator.dart';
import 'package:Dashtronaut/services/storage/storage_service.dart';

class PuzzleProvider with ChangeNotifier {
  final StorageService _storageService = getIt<StorageService>();

  /// One dimensional size of the puzzle => size = n x n (Default = 4x4)
  int n = Puzzle.supportedPuzzleSizes[1];

  void resetPuzzleSize(int size) {
    assert(Puzzle.supportedPuzzleSizes.contains(size));
    n = size;
    movesCount = 0;
    _storageService.remove(StorageKey.puzzle);
    generate(forceRefresh: true);
  }

  /// Random value used in shuffling tiles
  final Random random = Random();

  /// List of tiles of the puzzle
  late List<Tile> tiles;

  /// list of [tiles] excluding white space tile
  List<Tile> get tilesWithoutWhitespace => tiles.where((tile) => !tile.tileIsWhiteSpace).toList();

  int movesCount = 0;

  bool get hasStarted => movesCount > 0;

  int get correctTilesCount {
    int _count = 0;
    for (Tile tile in tiles) {
      if (tile.isAtCorrectLocation && !tile.tileIsWhiteSpace) {
        _count++;
      }
    }
    return _count;
  }

  /// Getter for puzzle object
  Puzzle get puzzle => Puzzle(
        n: n,
        tiles: tiles,
        movesCount: movesCount,
      );

  /// Action that switches the [Location]'s => [Position]'s of the tile
  /// dragged by the user & the whitespace tile
  /// This causes the [tile.position] getter to get the correct position based on new [Location]'s
  void swapTilesAndUpdatePuzzle(Tile tile) {
    int movedTileIndex = tiles.indexWhere((_tile) => _tile.value == tile.value);
    int whiteSpaceTileIndex = tiles.indexWhere((_tile) => _tile.tileIsWhiteSpace);
    // Store instances of the moved tile and the white space tile before changing their locations
    Tile _movedTile = tiles[movedTileIndex];
    Tile _whiteSpaceTile = tiles[whiteSpaceTileIndex];

    tiles[movedTileIndex] = tiles[movedTileIndex].copyWith(currentLocation: _whiteSpaceTile.currentLocation);
    tiles[whiteSpaceTileIndex] = _whiteSpaceTile.copyWith(currentLocation: _movedTile.currentLocation);

    print('Number of correct tiles ${puzzle.getNumberOfCorrectTiles()} | Is solved: ${puzzle.isSolved}');

    if (tiles[movedTileIndex].isAtCorrectLocation) {
      if (puzzle.isSolved) {
        HapticFeedback.vibrate();
      } else {
        HapticFeedback.mediumImpact();
      }
    }

    movesCount++;
    _updatePuzzleInStorage();
    notifyListeners();
  }

  Puzzle? _getPuzzleFromStorage() {
    dynamic _puzzle = _storageService.get(StorageKey.puzzle);
    return Puzzle.fromJson(json.decode(json.encode(_puzzle)));
  }

  void _updatePuzzleInStorage() {
    _storageService.set(StorageKey.puzzle, puzzle.toJson());
  }

  /// Generates tiles with shuffle
  void generate({bool forceRefresh = false}) {
    // Set tiles & size from locale storage only of they exist and there is no forceRefresh flag (for reset)

    if (_storageService.has(StorageKey.puzzle) && !forceRefresh) {
      Puzzle? _puzzle = _getPuzzleFromStorage();
      if (_puzzle != null) {
        tiles = _puzzle.tiles;
        n = _puzzle.n;
        movesCount = _puzzle.movesCount;
        return;
      }
    }
    movesCount = 0;
    _generateNew();
    _updatePuzzleInStorage();
    notifyListeners();
  }

  void _generateNew() {
    List<Location> _tilesCorrectLocations = Puzzle.generateTileCorrectLocations(n);
    List<Location> _tilesCurrentLocations = List.from(_tilesCorrectLocations);

    tiles = Puzzle.getTilesFromLocations(
      n: n,
      correctLocations: _tilesCorrectLocations,
      currentLocations: _tilesCurrentLocations,
    );

    while (!puzzle.isSolvable() || puzzle.getNumberOfCorrectTiles() != 0) {
      _tilesCurrentLocations.shuffle(random);

      tiles = Puzzle.getTilesFromLocations(
        n: n,
        correctLocations: _tilesCorrectLocations,
        currentLocations: _tilesCurrentLocations,
      );
    }
  }
}
