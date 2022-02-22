import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/data/models/dash.dart';
import 'package:flutter_puzzle_hack/data/models/position.dart';
import 'package:flutter_puzzle_hack/presentation/layout/screen_type_helper.dart';
import 'package:flutter_puzzle_hack/presentation/phrases/widgets/phrase_bubble.dart';

import '../../presentation/animations/widgets/scale_up_transition.dart';

class PhraseBubbleLayout {
  final BuildContext context;

  PhraseBubbleLayout(this.context);

  ScreenType get screenType => ScreenTypeHelper(context).type;

  Dash get _dash => Dash(context);

  Position get position => Position(
        right: _dash.size.width + (_dash.position.right ?? 0) - 10,
        bottom: (_dash.size.height * 0.2) + (_dash.position.bottom ?? 0),
      );
}
