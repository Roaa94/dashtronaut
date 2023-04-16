import 'package:dashtronaut/background/widgets/background_stack.dart';
import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/animations/widgets/scale_up_transition.dart';
import 'package:dashtronaut/core/layout/puzzle_layout.dart';
import 'package:dashtronaut/dash/widgets/dash.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleView extends ConsumerWidget {
  const PuzzleView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PuzzleLayout puzzleLayout = PuzzleLayout(context);

    return Stack(
      children: [
        const BackgroundStack(),
        ...puzzleLayout.buildUIElements,
        const ScaleUpTransition(
          delay: AnimationsManager.bgLayerAnimationDuration,
          child: PuzzleBoard(),
        ),
        const Dash(),
      ],
    );
  }
}
