import 'package:dashtronaut/dash/widgets/animated_phrase_bubble.dart';
import 'package:dashtronaut/background/widgets/background_stack.dart';
import 'package:dashtronaut/dash/widgets/dash_rive_animation.dart';
import 'package:dashtronaut/core/layout/puzzle_layout.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_board.dart';
import 'package:dashtronaut/puzzle/providers/old_puzzle_provider.dart';
import 'package:dashtronaut/puzzle/providers/stop_watch_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PuzzleView extends StatefulWidget {
  const PuzzleView({Key? key}) : super(key: key);

  @override
  State<PuzzleView> createState() => _PuzzleViewState();
}

class _PuzzleViewState extends State<PuzzleView> {
  late OldPuzzleProvider puzzleProvider;
  late StopWatchProvider stopWatchProvider;

  @override
  void initState() {
    puzzleProvider = Provider.of<OldPuzzleProvider>(context, listen: false);
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
        // const BackgroundStack(),
        // ...puzzleLayout.buildUIElements,
        PuzzleBoard(),
        // const DashRiveAnimation(),
        // const AnimatedPhraseBubble(),
      ],
    );
  }
}
