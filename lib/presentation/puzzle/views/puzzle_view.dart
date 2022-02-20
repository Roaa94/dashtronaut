import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/constants/ui.dart';
import 'package:flutter_puzzle_hack/presentation/background/widgets/background_wrapper.dart';
import 'package:flutter_puzzle_hack/presentation/drawer/widgets/drawer_button.dart';
import 'package:flutter_puzzle_hack/presentation/home/widgets/puzzle_header.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/puzzle/widgets/puzzle_board.dart';
import 'package:flutter_puzzle_hack/presentation/puzzle/widgets/reset_puzzle_button.dart';
import 'package:provider/provider.dart';

class PuzzleView extends StatelessWidget {
  const PuzzleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PuzzleProvider puzzleProvider = Provider.of<PuzzleProvider>(context, listen: false);

    return Stack(
      children: [
        const BackgroundWrapper(),
        ..._buildUIElements(context, puzzleProvider),
        PuzzleBoard(),
      ],
    );
  }

  List<Widget> _buildUIElements(BuildContext context, PuzzleProvider puzzleProvider) {
    if (puzzleProvider.landscapeMode) {
      // Landscape orientation for phones only
      return [
        Positioned(
          width: puzzleProvider.distanceOutsidePuzzle -
              puzzleProvider.puzzleContainerWidth -
              MediaQuery.of(context).padding.left -
              (!kIsWeb && Platform.isAndroid ? UI.space : 0),
          top: !kIsWeb && Platform.isAndroid ? MediaQuery.of(context).padding.top + UI.space : MediaQuery.of(context).padding.bottom,
          left: !kIsWeb && Platform.isAndroid ? UI.space : MediaQuery.of(context).padding.left,
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
              ? UI.space
              : !kIsWeb && Platform.isAndroid
                  ? MediaQuery.of(context).padding.top + UI.space
                  : MediaQuery.of(context).padding.top,
          left: UI.screenHPadding,
          child: const DrawerButton(),
        ),
        Positioned(
          bottom: puzzleProvider.distanceOutsidePuzzle,
          width: puzzleProvider.puzzleContainerWidth,
          left: (MediaQuery.of(context).size.width - puzzleProvider.puzzleContainerWidth) / 2,
          child: const PuzzleHeader(),
        ),
        Positioned(
          top: puzzleProvider.distanceOutsidePuzzle,
          right: 0,
          left: 0,
          child: const Center(child: ResetPuzzleButton()),
        ),
      ];
    }
  }
}
