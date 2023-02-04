import 'package:dashtronaut/configs/providers/configs_provider.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/layout/puzzle_layout.dart';
import 'package:dashtronaut/core/styles/app_text_styles.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_is_solved_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/puzzle/widgets/tile/tile_rive_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TileContent extends ConsumerStatefulWidget {
  final Tile tile;

  const TileContent({
    super.key,
    required this.tile,
  });

  @override
  ConsumerState<TileContent> createState() => _TileContentState();
}

class _TileContentState extends ConsumerState<TileContent>
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
    final isPuzzleSolved = ref.watch(puzzleIsSolvedProvider);
    final puzzleSize = ref.watch(puzzleSizeProvider);
    final configs = ref.watch(configsProvider);

    return MouseRegion(
      onEnter: (_) {
        if (!isPuzzleSolved) {
          _animationController.forward();
        }
      },
      onExit: (_) {
        if (!isPuzzleSolved) {
          _animationController.reverse();
        }
      },
      child: ScaleTransition(
        scale: _scale,
        child: Padding(
          padding: EdgeInsets.all(
            puzzleSize > configs.smallTilePuzzleSize
                ? PuzzleLayout.smallTilePadding
                : PuzzleLayout.tilePadding,
          ),
          child: Stack(
            children: [
              TileRiveAnimation(
                isAtCorrectLocation:
                    widget.tile.currentLocation == widget.tile.correctLocation,
                isPuzzleSolved: isPuzzleSolved,
              ),
              Positioned.fill(
                child: Center(
                  child: Text(
                    '${widget.tile.value}',
                    style: AppTextStyles.tile.copyWith(
                      fontSize: PuzzleLayout.tileTextSize(puzzleSize),
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
