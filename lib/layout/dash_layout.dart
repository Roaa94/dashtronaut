import 'package:dashtronaut/core/models/position.dart';
import 'package:dashtronaut/layout/layout_delegate.dart';
import 'package:dashtronaut/layout/puzzle_layout.dart';
import 'package:dashtronaut/layout/screen_type_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class DashLayout implements LayoutDelegate {
  @override
  final BuildContext context;

  DashLayout(this.context);

  @override
  ScreenTypeHelper get screenTypeHelper => ScreenTypeHelper(context);

  PuzzleLayout get puzzleLayout => PuzzleLayout(context);

  Size get size {
    double puzzleWidth = puzzleLayout.containerWidth;

    late double dashHeight;

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      switch (screenTypeHelper.type) {
        case ScreenType.xSmall:
        case ScreenType.small:
          dashHeight = MediaQuery.of(context).size.height * 0.5;
          break;
        case ScreenType.medium:
          if (!kIsWeb) {
            dashHeight = MediaQuery.of(context).size.height * 0.35;
          } else {
            dashHeight = MediaQuery.of(context).size.height * 0.5;
          }
          break;
        case ScreenType.large:
          dashHeight = MediaQuery.of(context).size.height * 0.35;
      }
    } else {
      dashHeight =
          ((MediaQuery.of(context).size.height - puzzleWidth) / 2) * 0.85;
    }
    return Size(dashHeight, dashHeight);
  }

  Position get position {
    switch (screenTypeHelper.type) {
      case ScreenType.xSmall:
      case ScreenType.small:
        return const Position(right: -10, bottom: 20);
      case ScreenType.medium:
        return const Position(right: 0, bottom: 20);
      case ScreenType.large:
        return const Position(right: 0, bottom: 70);
    }
  }
}
