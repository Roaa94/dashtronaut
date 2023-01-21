import 'package:dashtronaut/core/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final puzzleSizeProvider = StateProvider<int>(
  (ref) => Constants.supportedPuzzleSizes[1],
);
