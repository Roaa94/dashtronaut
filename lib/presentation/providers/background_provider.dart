import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/models/background.dart';

class BackgroundProvider with ChangeNotifier {
  final BuildContext context;

  BackgroundProvider(this.context);

  final Random random = Random();

  double get starsMaxXOffset =>
      MediaQuery.of(context).orientation == Orientation.landscape ? MediaQuery.of(context).size.height : MediaQuery.of(context).size.width;

  double get starsMaxYOffset =>
      MediaQuery.of(context).orientation == Orientation.landscape ? MediaQuery.of(context).size.width : MediaQuery.of(context).size.height;

  List<int> get randomStarXOffsets => _getRandomStarsOffsetsList(starsMaxXOffset.floor());

  List<int> get randomStarYOffsets => _getRandomStarsOffsetsList(starsMaxYOffset.floor());

  List<int> _getRandomStarsOffsetsList(int max) {
    List<int> _offsets = [];
    for (int i = 0; i <= Background.totalStarsCount; i++) {
      _offsets.add(random.nextInt(max));
    }
    return _offsets;
  }

  List<double> get randomStarSizes {
    List<double> _sizes = [];
    for (int i = 0; i <= Background.totalStarsCount; i++) {
      _sizes.add(random.nextDouble() + 0.4);
    }
    return _sizes;
  }
}
