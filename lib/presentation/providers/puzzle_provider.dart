import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_puzzle_hack/data/models/location.dart';
import 'package:flutter_puzzle_hack/data/models/position.dart';
import 'package:flutter_puzzle_hack/data/models/puzzle.dart';
import 'package:flutter_puzzle_hack/data/models/tile.dart';
import 'package:flutter_puzzle_hack/domain/service_locator.dart';
import 'package:flutter_puzzle_hack/domain/storage/storage_service.dart';

class PuzzleProvider with ChangeNotifier {
  final StorageService _storageService = getIt<StorageService>();

  /// One dimensional size of the puzzle => size = n x n
  int n = Puzzle.supportedPuzzleSizes[0];

  void resetPuzzleSize(int size) {
    assert(Puzzle.supportedPuzzleSizes.contains(size));
    n = size;
    _updatePuzzleSizeInStorage();
    generate(forceRefresh: true);
  }

  /// Random value used in shuffling tiles
  final Random random = Random();

  static const Duration dragAnimationDuration = Duration(milliseconds: 0);
  static const Duration snapAnimationDuration = Duration(milliseconds: 150);

  /// List of tiles of the puzzle
  late List<Tile> tiles;

  /// list of [tiles] excluding white space tile
  List<Tile> get tilesWithoutWhitespace => tiles.where((tile) => !tile.tileIsWhiteSpace).toList();

  /// list of [tiles] top of || bottom of || left of || right of white space tile
  List<Tile> get tilesAroundWhiteSpace => tiles.where((tile) => puzzle.tileIsMovable(tile)).toList();

  /// Getter for puzzle object
  Puzzle get puzzle => Puzzle(n: n, tiles: tiles);

  /// Return a [Tile] from its value
  Tile getTileFromValue(int tileValue) => tiles.singleWhere((tile) => tile.value == tileValue);

  /// Action that switches the [Location]'s => [Position]'s of the tile
  /// dragged by the user & the whitespace tile
  /// This causes the [Tile.position] getter to get the correct position based on new [Location]'s
  void swapTilesAndUpdatePuzzle(Tile tile) {
    int movedTileIndex = tiles.indexWhere((_tile) => _tile.value == tile.value);
    int whiteSpaceTileIndex = tiles.indexWhere((_tile) => _tile.tileIsWhiteSpace);
    // Store instances of the moved tile and the white space tile before changing their locations
    Tile _movedTile = tiles[movedTileIndex];
    Tile _whiteSpaceTile = tiles[whiteSpaceTileIndex];

    tiles[movedTileIndex] = tiles[movedTileIndex].copyWith(currentLocation: _whiteSpaceTile.currentLocation);
    tiles[whiteSpaceTileIndex] = _whiteSpaceTile.copyWith(currentLocation: _movedTile.currentLocation);

    print('Number of correct tiles ${puzzle.getNumberOfCorrectTiles()} | Is solved: ${puzzle.isSolved}');
    // If the above switch in positions causes the `activeTile` to become not around
    // the white space tile (not movable) reset the value of the `activeTileValue` to the first movable tile's value
    _updateTilesInStorage();
    notifyListeners();
  }

  void _updateTilesInStorage() {
    _storageService.set(StorageKey.tiles, List<dynamic>.from(tiles.map((x) => x.toJson())));
  }

  List<Tile> _getTilesFromStorage() {
    List<dynamic> _tiles = _storageService.get(StorageKey.tiles);
    return List<Tile>.from(_tiles.map((x) => Tile.fromJson(json.decode(json.encode(x)))));
  }

  void _updatePuzzleSizeInStorage() {
    _storageService.set(StorageKey.puzzleSize, n);
  }

  /// Generates tiles with shuffle
  void generate({bool forceRefresh = false}) {
    // Set tiles & size from locale storage only of they exist and there is no forceRefresh flag (for reset)
    if (_storageService.has(StorageKey.puzzleSize) && _storageService.has(StorageKey.tiles) && !forceRefresh) {
      tiles = _getTilesFromStorage();
      n = _storageService.get(StorageKey.puzzleSize);
    } else {
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
    _updatePuzzleSizeInStorage();
    _updateTilesInStorage();
    notifyListeners();
  }
}
