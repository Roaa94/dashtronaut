import 'dart:io';

import 'package:dashtronaut/background/widgets/background_stack.dart';
import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/animations/widgets/scale_up_transition.dart';
import 'package:dashtronaut/core/layout/puzzle_layout.dart';
import 'package:dashtronaut/core/layout/screen_type_helper.dart';
import 'package:dashtronaut/core/layout/spacing.dart';
import 'package:dashtronaut/dash/widgets/dash.dart';
import 'package:dashtronaut/drawer/widgets/drawer_button.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_board.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_header.dart';
import 'package:dashtronaut/puzzle/widgets/reset_puzzle_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleView extends ConsumerWidget {
  const PuzzleView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenTypeHelper screenTypeHelper = ScreenTypeHelper(context);
    PuzzleLayout puzzleLayout = PuzzleLayout(context);

    return Stack(
      children: [
        const BackgroundStack(),
        ...(screenTypeHelper.landscapeMode
            ? _buildHorizontalPuzzleElements(context)
            : _buildVerticalPuzzleElements(context)),
        ScaleUpTransition(
          delay: AnimationsManager.bgLayerAnimationDuration,
          child: PuzzleBoard(
            puzzleContainerWidth: puzzleLayout.containerWidth,
          ),
        ),
        const Dash(),
      ],
    );
  }

  List<Widget> _buildHorizontalPuzzleElements(BuildContext context) {
    final puzzleLayout = PuzzleLayout(context);
    final screenPadding = MediaQuery.of(context).padding;

    return [
      Positioned(
        width: _getDistanceOutsidePuzzle(context) -
            puzzleLayout.containerWidth -
            screenPadding.left -
            (!kIsWeb && Platform.isAndroid ? Spacing.md : 0),
        top: !kIsWeb && Platform.isAndroid
            ? screenPadding.top + Spacing.md
            : screenPadding.bottom,
        left: !kIsWeb && Platform.isAndroid ? Spacing.md : screenPadding.left,
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
  }

  List<Widget> _buildVerticalPuzzleElements(BuildContext context) {
    final puzzleLayout = PuzzleLayout(context);
    final screenPadding = MediaQuery.of(context).padding;
    final screenSize = MediaQuery.of(context).size;

    return [
      Positioned(
        top: kIsWeb
            ? Spacing.md
            : !kIsWeb && (Platform.isAndroid || Platform.isMacOS)
                ? screenPadding.top + Spacing.md
                : screenPadding.top,
        left: Spacing.screenHPadding,
        child: const DrawerButton(),
      ),
      Positioned(
        bottom: _getDistanceOutsidePuzzle(context),
        width: puzzleLayout.containerWidth,
        left: (screenSize.width - puzzleLayout.containerWidth) / 2,
        child: const PuzzleHeader(),
      ),
      Positioned(
        top: _getDistanceOutsidePuzzle(context),
        right: 0,
        left: (screenSize.width - puzzleLayout.containerWidth) / 2,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: ResetPuzzleButton(),
        ),
      ),
    ];
  }

  double _getDistanceOutsidePuzzle(BuildContext context) {
    final puzzleLayout = PuzzleLayout(context);
    final screenTypeHelper = ScreenTypeHelper(context);
    final screenSize = MediaQuery.of(context).size;

    double screenHeight =
        screenTypeHelper.landscapeMode ? screenSize.width : screenSize.height;

    return ((screenHeight - puzzleLayout.containerWidth) / 2) +
        puzzleLayout.containerWidth;
  }
}
