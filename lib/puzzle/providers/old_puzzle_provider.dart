import 'dart:convert';
import 'dart:developer';
import 'dart:math' show Random;

import 'package:dashtronaut/core/constants.dart';
import 'package:dashtronaut/core/models/location.dart';
import 'package:dashtronaut/core/models/position.dart';
import 'package:dashtronaut/core/models/puzzle.dart';
import 'package:dashtronaut/core/models/score.dart';
import 'package:dashtronaut/core/models/tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:dashtronaut/core/services/storage/storage.dart';

class OldPuzzleProvider with ChangeNotifier {
  final StorageService storageService;

  OldPuzzleProvider(this.storageService);

  /// One dimensional size of the puzzle => size = n x n (Default = 4x4)
  int n = Constants.supportedPuzzleSizes[1];

  void resetPuzzleSize(int size) {
    assert(Constants.supportedPuzzleSizes.contains(size));
    n = size;
    movesCount = 0;
    storageService.remove(StorageKeys.puzzle);
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

  void _updateScoresInStorage() {
    Score newScore = Score(
      movesCount: movesCount,
      puzzleSize: n,
      secondsElapsed: storageService.get(StorageKeys.secondsElapsed),
    );
    try {
      List<Score> scores = _getScoresFromStorage();
      if (scores.length == Constants.maxStorableScores) {
        scores.removeAt(0);
      }
      scores.add(newScore);
      storageService.set(StorageKeys.scores, Score.toJsonList(scores));
      scores = scores;
    } catch (e) {
      storageService.remove(StorageKeys.scores);
      log('Error updating scores in storage $e');
    }
  }

  List<Score> _getScoresFromStorage() {
    List<Score> storedScores = [];
    try {
      final scores = storageService.get(StorageKeys.scores);
      if (scores != null) {
        storedScores = Score.fromJsonList(scores);
      }
    } catch (e) {
      storageService.remove(StorageKeys.scores);
      log('Error retrieving scores from storage');
      log('$e');
    }
    return storedScores;
  }

  Puzzle? _getPuzzleFromStorage() {
    try {
      dynamic puzzle = storageService.get(StorageKeys.puzzle);
      return Puzzle.fromJson(json.decode(json.encode(puzzle)));
    } catch (e) {
      log('Error in local storage, clearing data...');
      storageService.clear();
      return null;
    }
  }

  void _updatePuzzleInStorage() {
    try {
      storageService.set(StorageKeys.puzzle, puzzle.toJson());
    } catch (e) {
      log('Error updating puzzle in storage');
      log('$e');
    }
  }

  /// Generates tiles with shuffle
  void generate({bool forceRefresh = false}) {
    if (storageService.has(StorageKeys.scores)) {
      scores = _getScoresFromStorage();
    }
    // Set tiles & size from locale storage only of they exist and there is no forceRefresh flag (for reset)
    if (storageService.has(StorageKeys.puzzle) && !forceRefresh) {
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
