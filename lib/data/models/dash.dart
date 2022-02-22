import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_puzzle_hack/data/models/position.dart';
import 'package:flutter_puzzle_hack/presentation/layout/screen_type_helper.dart';

class Dash {
  final BuildContext context;

  Dash(this.context);

  ScreenType get screenType => ScreenTypeHelper(context).type;

  Size get size {
    switch (screenType) {
      case ScreenType.xSmall:
        return const Size(170, 230);
      case ScreenType.small:
        return const Size(170, 230);
      case ScreenType.medium:
        if (!kIsWeb && MediaQuery.of(context).orientation != Orientation.landscape) {
          return const Size(300, 400);
        } else {
          return const Size(200, 250);
        }
      case ScreenType.large:
        return const Size(300, 400);
    }
  }

  Position get position {
    switch (screenType) {
      case ScreenType.xSmall:
        return const Position(right: 0, bottom: 0);
      case ScreenType.small:
        return const Position(right: 0, bottom: 0);
      case ScreenType.medium:
        return const Position(right: 0, bottom: 0);
      case ScreenType.large:
        return const Position(right: 0, bottom: 100);
    }
  }
}
