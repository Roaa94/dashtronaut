import 'dart:io';

import 'package:Dashtronaut/presentation/drawer/drawer_button.dart';
import 'package:Dashtronaut/presentation/layout/screen_type_helper.dart';
import 'package:Dashtronaut/presentation/layout/spacing.dart';
import 'package:Dashtronaut/presentation/puzzle/ui/puzzle_header.dart';
import 'package:Dashtronaut/presentation/puzzle/ui/reset_puzzle_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PuzzleLayout {
  final BuildContext context;

  PuzzleLayout(this.context);

  ScreenTypeHelper get screenTypeHelper => ScreenTypeHelper(context);

  double get containerWidth {
    ScreenType screenType = screenTypeHelper.type;

    switch (screenType) {
      case ScreenType.xSmall:
      case ScreenType.small:
        return MediaQuery.of(context).size.width - Spacing.screenHPadding * 2;
      case ScreenType.medium:
        if (screenTypeHelper.landscapeMode) {
          return MediaQuery.of(context).size.flipped.width - Spacing.screenHPadding * 2;
        } else {
          return 500;
        }
      case ScreenType.large:
        return 500;
    }
  }

  double get distanceOutsidePuzzle {
    double screenHeight = screenTypeHelper.landscapeMode ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height;
    return ((screenHeight - containerWidth) / 2) + containerWidth;
  }

  static const double tilePadding = 4;

  static double? tileTextSize(int puzzleSize) {
    return puzzleSize > 5
        ? 20
        : puzzleSize > 4
            ? 25
            : puzzleSize > 3
                ? 30
                : null;
  }

  List<Widget> get horizontalPuzzleUIElements {
    return [
      Positioned(
        width: distanceOutsidePuzzle - containerWidth - MediaQuery.of(context).padding.left - (!kIsWeb && Platform.isAndroid ? Spacing.md : 0),
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
  }

  List<Widget> get verticalPuzzleUIElements {
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
        bottom: distanceOutsidePuzzle,
        width: containerWidth,
        left: (MediaQuery.of(context).size.width - containerWidth) / 2,
        child: const PuzzleHeader(),
      ),
      Positioned(
        top: distanceOutsidePuzzle,
        right: 0,
        left: (MediaQuery.of(context).size.width - containerWidth) / 2,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: ResetPuzzleButton(),
        ),
      ),
    ];
  }

  List<Widget> get buildUIElements {
    return screenTypeHelper.landscapeMode ? horizontalPuzzleUIElements : verticalPuzzleUIElements;
  }
}
