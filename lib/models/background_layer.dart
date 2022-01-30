import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/models/vector.dart';

class BackgroundLayer {
  String assetUrl;
  Position position;

  BackgroundLayer({
    required this.assetUrl,
    required this.position,
  });
}
