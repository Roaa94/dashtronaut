import 'package:flutter/cupertino.dart';
import 'package:Dashtronaut/presentation/layout/dash_layout.dart';
import 'package:Dashtronaut/models/position.dart';
import 'package:Dashtronaut/presentation/layout/screen_type_helper.dart';

enum PhraseState {
  none,
  puzzleStarted,
  puzzleSolved,
  hardPuzzleSelected,
  puzzleTakingTooLong,
  dashTapped,
  doingGreat,
}

class PhraseBubbleLayout {
  final BuildContext context;

  PhraseBubbleLayout(this.context);

  ScreenType get screenType => ScreenTypeHelper(context).type;

  DashLayout get _dash => DashLayout(context);

  Position get position {
    switch (screenType) {
      case ScreenType.xSmall:
      case ScreenType.small:
        return Position(
          right: _dash.size.width + (_dash.position.right ?? 0) - 20,
          bottom: (_dash.size.height * 0.1) + (_dash.position.bottom ?? 0),
        );
      case ScreenType.medium:
        return Position(
          right: _dash.size.width + (_dash.position.right ?? 0) - 40,
          bottom: _dash.position.bottom,
        );
      case ScreenType.large:
        return Position(
          right: _dash.size.width + (_dash.position.right ?? 0) - 70,
          bottom: (_dash.size.height * 0.1) + (_dash.position.bottom ?? 0),
        );
    }
  }
}
