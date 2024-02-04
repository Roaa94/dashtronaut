import 'package:dashtronaut/core/animations/widgets/pulse_transition.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/layout/puzzle_layout.dart';
import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:dashtronaut/puzzle/widgets/tile/tile_rive_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleTile extends ConsumerStatefulWidget {
  const PuzzleTile({
    super.key,
    required this.tile,
    this.isPuzzleSolved = false,
    required this.puzzleSize,
    this.isMovable = false,
  });

  final Tile tile;
  final bool isPuzzleSolved;
  final int puzzleSize;
  final bool isMovable;

  @override
  ConsumerState<PuzzleTile> createState() => PuzzleTileState();
}

class PuzzleTileState extends ConsumerState<PuzzleTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late Animation<double> _scale;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: AnimationsManager.tileHover.duration,
    );

    _scale = AnimationsManager.tileHover.tween.animate(
      CurvedAnimation(
        parent: animationController,
        curve: AnimationsManager.tileHover.curve,
      ),
    );
    super.initState();
  }

  static const double defaultTilePadding = 4;
  static const double smallTilePadding = 2;
  static const int smallTilePuzzleSize = 4;

  @override
  Widget build(BuildContext context) {
    return PulseTransition(
      isActive: widget.isMovable,
      child: MouseRegion(
        onEnter: (_) {
          if (!widget.isPuzzleSolved) {
            animationController.forward();
          }
        },
        onExit: (_) {
          if (!widget.isPuzzleSolved) {
            animationController.reverse();
          }
        },
        child: ScaleTransition(
          scale: _scale,
          child: Padding(
            padding: EdgeInsets.all(
              widget.puzzleSize > smallTilePuzzleSize
                  ? smallTilePadding
                  : defaultTilePadding,
            ),
            child: Stack(
              children: [
                TileRiveAnimation(
                  isAtCorrectLocation: widget.tile.currentLocation ==
                      widget.tile.correctLocation,
                  isPuzzleSolved: widget.isPuzzleSolved,
                ),
                Positioned.fill(
                  child: Center(
                    child: Text(
                      '${widget.tile.value}',
                      style: AppTextStyles.tile.copyWith(
                        fontSize: widget.puzzleSize > 5
                            ? 20
                            : widget.puzzleSize > 4
                                ? 25
                                : widget.puzzleSize > 3
                                    ? 30
                                    : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
