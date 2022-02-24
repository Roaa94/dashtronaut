import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/presentation/layout/puzzle_layout.dart';
import 'package:flutter_puzzle_hack/presentation/layout/screen_type_helper.dart';

class DashLayout {
  final BuildContext context;

  DashLayout(this.context);

  ScreenTypeHelper get screenTypeHelper => ScreenTypeHelper(context);

  ScreenType get screenType => screenTypeHelper.type;

  Size get size {
    double puzzleWidth = PuzzleLayout.containerWidth(context);

    late double dashHeight;

    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      switch (screenType) {
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
      dashHeight = ((MediaQuery.of(context).size.height - puzzleWidth) / 2) * 0.85;
    }
    return Size(dashHeight, dashHeight);
  }

  Position get position {
    switch (screenType) {
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
