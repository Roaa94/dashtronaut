import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/layout/puzzle_layout.dart';
import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:dashtronaut/puzzle/widgets/tile/tile_rive_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TileContent extends ConsumerStatefulWidget {
  const TileContent({
    super.key,
    required this.tile,
    this.isPuzzleSolved = false,
    required this.puzzleSize,
  });

  final Tile tile;
  final bool isPuzzleSolved;
  final int puzzleSize;

  @override
  ConsumerState<TileContent> createState() => TileContentState();
}

class TileContentState extends ConsumerState<TileContent>
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

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
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
          padding: EdgeInsets.all(PuzzleLayout.tilePadding(widget.puzzleSize)),
          child: Stack(
            children: [
              TileRiveAnimation(
                isAtCorrectLocation:
                    widget.tile.currentLocation == widget.tile.correctLocation,
                isPuzzleSolved: widget.isPuzzleSolved,
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    '${widget.tile.value}',
                    style: AppTextStyles.tile.copyWith(
                      fontSize: PuzzleLayout.tileTextSize(widget.puzzleSize),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
