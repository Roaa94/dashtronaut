import 'package:dashtronaut/core/models/tile.dart';
import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/layout/puzzle_layout.dart';
import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:dashtronaut/tile/tile_rive_animation.dart';
import 'package:flutter/material.dart';

class TileContent extends StatefulWidget {
  final Tile tile;
  final bool isPuzzleSolved;
  final int puzzleSize;

  const TileContent({
    Key? key,
    required this.tile,
    required this.isPuzzleSolved,
    required this.puzzleSize,
  }) : super(key: key);

  @override
  State<TileContent> createState() => _TileContentState();
}

class _TileContentState extends State<TileContent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> _scale;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: AnimationsManager.tileHover.duration,
    );

    _scale = AnimationsManager.tileHover.tween.animate(
      CurvedAnimation(
        parent: _animationController,
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
          _animationController.forward();
        }
      },
      onExit: (_) {
        if (!widget.isPuzzleSolved) {
          _animationController.reverse();
        }
      },
      child: ScaleTransition(
        scale: _scale,
        child: Padding(
          padding: EdgeInsets.all(
              widget.puzzleSize > 4 ? 2 : PuzzleLayout.tilePadding),
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
                        fontSize: PuzzleLayout.tileTextSize(widget.puzzleSize)),
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
