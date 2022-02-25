import 'dart:io';

import 'package:Dashtronaut/presentation/background/widgets/background_stack.dart';
import 'package:Dashtronaut/presentation/dash/dash_rive_animation.dart';
import 'package:Dashtronaut/presentation/drawer/drawer_button.dart';
import 'package:Dashtronaut/presentation/layout/puzzle_layout.dart';
import 'package:Dashtronaut/presentation/layout/spacing.dart';
import 'package:Dashtronaut/presentation/phrases/animated_phrase_bubble.dart';
import 'package:Dashtronaut/presentation/providers/puzzle_provider.dart';
import 'package:Dashtronaut/presentation/providers/stop_watch_provider.dart';
import 'package:Dashtronaut/presentation/puzzle/board/puzzle_board.dart';
import 'package:Dashtronaut/presentation/puzzle/ui/puzzle_header.dart';
import 'package:Dashtronaut/presentation/puzzle/ui/reset_puzzle_button.dart';
import 'package:flutter/foundation.dart';
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
    return Stack(
      children: [
        const BackgroundStack(),
        ..._buildUIElements(context),
        PuzzleBoard(),
        const DashRiveAnimation(),
        const AnimatedPhraseBubble(),
      ],
    );
  }

  List<Widget> _buildUIElements(BuildContext context) {
    if (PuzzleLayout.landscapeMode(context)) {
      // Landscape orientation for phones only
      return [
        Positioned(
          width: PuzzleLayout.distanceOutsidePuzzle(context) -
              PuzzleLayout.containerWidth(context) -
              MediaQuery.of(context).padding.left -
              (!kIsWeb && Platform.isAndroid ? Spacing.md : 0),
          top: !kIsWeb && Platform.isAndroid ? MediaQuery.of(context).padding.top + Spacing.md : MediaQuery.of(context).padding.bottom,
          left: !kIsWeb && Platform.isAndroid ? Spacing.md : MediaQuery.of(context).padding.left,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              DrawerButton(),
              SizedBox(height: 20),
              PuzzleHeader(),
              ResetPuzzleButton(),
            ],
          ),
        ),
      ];
    } else {
      // Portrait view for all devices and platforms
      return [
        Positioned(
          top: kIsWeb
              ? Spacing.md
              : !kIsWeb && (Platform.isAndroid || Platform.isMacOS)
                  ? MediaQuery.of(context).padding.top + Spacing.md
                  : MediaQuery.of(context).padding.top,
          left: Spacing.screenHPadding,
          child: const DrawerButton(),
        ),
        Positioned(
          bottom: PuzzleLayout.distanceOutsidePuzzle(context),
          width: PuzzleLayout.containerWidth(context),
          left: (MediaQuery.of(context).size.width - PuzzleLayout.containerWidth(context)) / 2,
          child: const PuzzleHeader(),
        ),
        Positioned(
          top: PuzzleLayout.distanceOutsidePuzzle(context),
          right: 0,
          left: (MediaQuery.of(context).size.width - PuzzleLayout.containerWidth(context)) / 2,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: ResetPuzzleButton(),
          ),
        ),
      ];
    }
  }
}
