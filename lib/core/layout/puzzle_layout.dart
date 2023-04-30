import 'dart:io';

import 'package:dashtronaut/drawer/widgets/drawer_button.dart';
import 'package:dashtronaut/core/layout/layout_delegate.dart';
import 'package:dashtronaut/core/layout/screen_type_helper.dart';
import 'package:dashtronaut/core/layout/spacing.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_header.dart';
import 'package:dashtronaut/puzzle/widgets/reset_puzzle_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PuzzleLayout implements LayoutDelegate {
  @override
  final BuildContext context;

  PuzzleLayout(this.context);

  @override
  ScreenTypeHelper get screenTypeHelper => ScreenTypeHelper(context);

  double get containerWidth {
    switch (screenTypeHelper.type) {
      case ScreenType.xSmall:
      case ScreenType.small:
        return MediaQuery.of(context).size.width - Spacing.screenHPadding * 2;
      case ScreenType.medium:
        if (screenTypeHelper.landscapeMode) {
          return MediaQuery.of(context).size.flipped.width -
              Spacing.screenHPadding * 2;
        } else {
          return 500;
        }
      case ScreenType.large:
        return 500;
    }
  }
}
