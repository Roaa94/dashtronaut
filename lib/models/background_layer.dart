import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/models/position.dart';

enum BackgroundLayerType {
  topRightPlanet,
  topLeftPlanet,
  topBgPlanet,
  bottomLeftPlanet,
  bottomRightPlanet,
  bottomBgPlanet,
}

class BackgroundLayer {
  BackgroundLayerType type;
  String assetUrl;
  Position position;
  Size size;

  BackgroundLayer({
    required this.type,
    required this.assetUrl,
    required this.position,
    required this.size,
  });
}
