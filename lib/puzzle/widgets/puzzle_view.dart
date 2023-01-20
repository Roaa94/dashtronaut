import 'package:dashtronaut/presentation/background/widgets/background_stack.dart';
import 'package:dashtronaut/presentation/dash/dash_rive_animation.dart';
import 'package:dashtronaut/presentation/layout/puzzle_layout.dart';
import 'package:dashtronaut/presentation/phrases/animated_phrase_bubble.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_board.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_provider.dart';
import 'package:dashtronaut/providers/stop_watch_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PuzzleView extends StatefulWidget {
  const PuzzleView({Key? key}) : super(key: key);

  @override
  State<PuzzleView> createState() => _PuzzleViewState();
}

class _PuzzleViewState extends State<PuzzleView> {
  late PuzzleProvider puzzleProvider;
  late StopWatchProvider stopWatchProvider;

  @override
  void initState() {
    puzzleProvider = Provider.of<PuzzleProvider>(context, listen: false);
    stopWatchProvider = Provider.of<StopWatchProvider>(context, listen: false);
    if (puzzleProvider.hasStarted) {
      stopWatchProvider.start();
    }
    super.initState();
  }

  @override
  void dispose() {
    stopWatchProvider.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PuzzleLayout puzzleLayout = PuzzleLayout(context);
    return Stack(
      children: [
        const BackgroundStack(),
        ...puzzleLayout.buildUIElements,
        PuzzleBoard(),
        const DashRiveAnimation(),
        const AnimatedPhraseBubble(),
      ],
    );
  }
}
