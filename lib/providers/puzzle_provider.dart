import 'dart:convert';
import 'dart:developer';
import 'dart:math' show Random;

import 'package:dashtronaut/models/location.dart';
import 'package:dashtronaut/models/position.dart';
import 'package:dashtronaut/models/puzzle.dart';
import 'package:dashtronaut/models/score.dart';
import 'package:dashtronaut/models/tile.dart';
import 'package:dashtronaut/services/storage/storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PuzzleProvider with ChangeNotifier {
  final StorageService storageService;

  PuzzleProvider(this.storageService);

  /// One dimensional size of the puzzle => size = n x n (Default = 4x4)
  int n = Puzzle.supportedPuzzleSizes[1];

  void resetPuzzleSize(int size) {
    assert(Puzzle.supportedPuzzleSizes.contains(size));
    n = size;
    movesCount = 0;
    storageService.remove(StorageKey.puzzle);
    generate(forceRefresh: true);
  }

  /// Random value used in shuffling tiles
  final Random random = Random();

  /// List of tiles of the puzzle
  late List<Tile> tiles;

  /// list of [tiles] excluding white space tile
  List<Tile> get tilesWithoutWhitespace =>
      tiles.where((tile) => !tile.tileIsWhiteSpace).toList();

  int movesCount = 0;

  bool get hasStarted => movesCount > 0;

  int get correctTilesCount {
    int count = 0;
    for (Tile tile in tiles) {
      if (tile.isAtCorrectLocation && !tile.tileIsWhiteSpace) {
        count++;
      }
    }
    return count;
  }

  /// Getter for puzzle object
  Puzzle get puzzle => Puzzle(
        n: n,
        tiles: tiles,
        movesCount: movesCount,
      );

  /// Handle Keyboard event and move appropriate tile
  void handleKeyboardEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      final physicalKey = event.data.physicalKey;
      Tile? tile;
      if (physicalKey == PhysicalKeyboardKey.arrowDown) {
        tile = puzzle.tileTopOfWhitespace;
      } else if (physicalKey == PhysicalKeyboardKey.arrowUp) {
        tile = puzzle.tileBottomOfWhitespace;
      } else if (physicalKey == PhysicalKeyboardKey.arrowRight) {
        tile = puzzle.tileLeftOfWhitespace;
      } else if (physicalKey == PhysicalKeyboardKey.arrowLeft) {
        tile = puzzle.tileRightOfWhitespace;
      }

      if (tile != null) {
        swapTilesAndUpdatePuzzle(tile);
      }
    }
  }

  /// Action that switches the [Location]'s => [Position]'s of the tile
  /// dragged by the user & the whitespace tile
  /// This causes the [tile.position] getter to get the correct position based on new [Location]'s
  void swapTilesAndUpdatePuzzle(Tile tile) {
    int movedTileIndex = tiles
        .indexWhere((ctile) => ctile.currentLocation == tile.currentLocation);
    int whiteSpaceTileIndex = tiles.indexWhere((tile) => tile.tileIsWhiteSpace);
    // Store instances of the moved tile and the white space tile before changing their locations
    Tile movedTile = tiles[movedTileIndex];
    Tile whiteSpaceTile = tiles[whiteSpaceTileIndex];

    tiles[movedTileIndex] = tiles[movedTileIndex]
        .copyWith(currentLocation: whiteSpaceTile.currentLocation);
    tiles[whiteSpaceTileIndex] =
        whiteSpaceTile.copyWith(currentLocation: movedTile.currentLocation);

    log('Number of correct tiles ${puzzle.getNumberOfCorrectTiles()} | Is solved: ${puzzle.isSolved}');

    if (tiles[movedTileIndex].isAtCorrectLocation) {
      if (puzzle.isSolved) {
        HapticFeedback.vibrate();
        _updateScoresInStorage();
      } else {
        HapticFeedback.mediumImpact();
      }
    }

    movesCount++;
    _updatePuzzleInStorage();
    notifyListeners();
  }

  List<Score> scores = <Score>[];

  static const int maxStorableScores = 10;

  void _updateScoresInStorage() {
    Score newScore = Score(
      movesCount: movesCount,
      puzzleSize: n,
      secondsElapsed: storageService.get(StorageKey.secondsElapsed),
    );
    try {
      List<Score> scores = _getScoresFromStorage();
      if (scores.length == maxStorableScores) {
        scores.removeAt(0);
      }
      scores.add(newScore);
      storageService.set(StorageKey.scores, Score.toJsonList(scores));
      scores = scores;
    } catch (e) {
      storageService.remove(StorageKey.scores);
      log('Error updating scores in storage $e');
    }
  }

  List<Score> _getScoresFromStorage() {
    List<Score> storedScores = [];
    try {
      final scores = storageService.get(StorageKey.scores);
      if (scores != null) {
        storedScores = Score.fromJsonList(scores);
      }
    } catch (e) {
      storageService.remove(StorageKey.scores);
      log('Error retrieving scores from storage');
      log('$e');
    }
    return storedScores;
  }

  Puzzle? _getPuzzleFromStorage() {
    try {
      dynamic puzzle = storageService.get(StorageKey.puzzle);
      return Puzzle.fromJson(json.decode(json.encode(puzzle)));
    } catch (e) {
      log('Error in local storage, clearing data...');
      storageService.clear();
      return null;
    }
  }

  void _updatePuzzleInStorage() {
    try {
      storageService.set(StorageKey.puzzle, puzzle.toJson());
    } catch (e) {
      log('Error updating puzzle in storage');
      log('$e');
    }
  }

  /// Generates tiles with shuffle
  void generate({bool forceRefresh = false}) {
    if (storageService.has(StorageKey.scores)) {
      scores = _getScoresFromStorage();
    }
    // Set tiles & size from locale storage only of they exist and there is no forceRefresh flag (for reset)
    if (storageService.has(StorageKey.puzzle) && !forceRefresh) {
      Puzzle? puzzle = _getPuzzleFromStorage();
      if (puzzle != null) {
        tiles = puzzle.tiles;
        n = puzzle.n;
        movesCount = puzzle.movesCount;
        return;
      }
    }
    movesCount = 0;
    _generateNew();
    _updatePuzzleInStorage();
    notifyListeners();
  }

  void _generateNew() {
    List<Location> tilesCorrectLocations =
        Puzzle.generateTileCorrectLocations(n);
    List<Location> tilesCurrentLocations = List.from(tilesCorrectLocations);

    tiles = Puzzle.getTilesFromLocations(
      correctLocations: tilesCorrectLocations,
      currentLocations: tilesCurrentLocations,
    );

    while (!puzzle.isSolvable() || puzzle.getNumberOfCorrectTiles() != 0) {
      tilesCurrentLocations.shuffle(random);

      tiles = Puzzle.getTilesFromLocations(
        correctLocations: tilesCorrectLocations,
        currentLocations: tilesCurrentLocations,
      );
    }
  }
}
