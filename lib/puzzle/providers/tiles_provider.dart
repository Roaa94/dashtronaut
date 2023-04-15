import 'dart:math';

import 'package:dashtronaut/core/services/game-logic/slide_puzzle_logic.dart';
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
          : slidePuzzleLogic.generateSolvableTiles(random),
      movesCount: puzzleRepository.get()?.movesCount ?? 0,
    );
  }

  PuzzleStorageRepository get puzzleRepository =>
      ref.watch(puzzleRepositoryProvider);

  int get puzzleSize => ref.watch(puzzleSizeProvider);

  SlidePuzzleLogic get slidePuzzleLogic => ref.watch(
        slidePuzzleLogicProvider(puzzleSize),
      );

  void reset() {
    state = TilesState(
      tiles: slidePuzzleLogic.generateSolvableTiles(random),
      movesCount: 0,
    );
    puzzleRepository.updatePuzzle(
      tiles: state.tiles,
      movesCount: state.movesCount,
    );
  }

  void swapTiles(Tile movedTile) {
    if (!state.isSolved && state.tileIsMovable(movedTile)) {
      final newTiles = [
        for (final tile in state.tiles)
          if (tile.currentLocation == movedTile.currentLocation)
            tile.copyWith(currentLocation: state.whiteSpaceTile.currentLocation)
          else if (tile == state.whiteSpaceTile)
            tile.copyWith(currentLocation: movedTile.currentLocation)
          else
            tile
      ];
      state = state.copyWith(
        tiles: newTiles,
        movesCount: state.movesCount + 1,
      );
      puzzleRepository.updatePuzzle(
        tiles: state.tiles,
        movesCount: state.movesCount,
      );
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
}
