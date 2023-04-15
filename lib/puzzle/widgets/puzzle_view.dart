import 'package:dashtronaut/background/widgets/background_stack.dart';
import 'package:dashtronaut/core/layout/puzzle_layout.dart';
import 'package:dashtronaut/dash/widgets/animated_phrase_bubble.dart';
import 'package:dashtronaut/dash/widgets/dash_rive_animation.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_board.dart';
import 'package:flutter/material.dart';

class PuzzleView extends StatelessWidget {
  const PuzzleView({super.key});

  @override
  Widget build(BuildContext context) {
    PuzzleLayout puzzleLayout = PuzzleLayout(context);
    return Stack(
      children: [
        const BackgroundStack(),
        ...puzzleLayout.buildUIElements,
        const PuzzleBoard(),
        // const DashRiveAnimation(),
        const AnimatedPhraseBubble(),
      ],
    );
  }
}
