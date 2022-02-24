import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/layout/screen_type_helper.dart';
import 'package:flutter_puzzle_hack/presentation/layout/spacing.dart';

class PuzzleLayout {

  static double containerWidth(BuildContext context) {
    ScreenType screenType = ScreenTypeHelper(context).type;

    switch (screenType) {
      case ScreenType.xSmall:
      case ScreenType.small:
        return MediaQuery.of(context).size.width - Spacing.screenHPadding * 2;
      case ScreenType.medium:
        if (landscapeMode(context)) {
          return MediaQuery.of(context).size.flipped.width - Spacing.screenHPadding * 2;
        } else {
          return 500;
        }
      case ScreenType.large:
        return 500;
    }
  }

  static bool landscapeMode(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape &&
        !kIsWeb &&
        !Platform.isMacOS &&
        MediaQuery.of(context).size.width < ScreenTypeHelper.breakpoints[ScreenType.medium]!;
  }

  static double distanceOutsidePuzzle(BuildContext context) {
    double screenHeight = landscapeMode(context) ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height;
    return ((screenHeight - containerWidth(context)) / 2) + containerWidth(context);
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
}