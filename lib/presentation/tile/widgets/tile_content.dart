import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/data/models/tile.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';
import 'package:flutter_puzzle_hack/presentation/tile/widgets/tile_rive_animation.dart';

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

class _TileContentState extends State<TileContent> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> _scale;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scale = Tween<double>(begin: 1, end: 0.94).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
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
          padding: EdgeInsets.all(widget.puzzleSize > 5
              ? 2
              : widget.puzzleSize > 3
                  ? 5
                  : 8),
          child: Stack(
            children: [
              TileRiveAnimation(
                isAtCorrectLocation: widget.tile.currentLocation == widget.tile.correctLocation,
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
                                    : null),
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
