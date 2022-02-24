import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/layout/background_layer.dart';

class Background {
  static List<BackgroundLayerType> backgroundLayerTypes = [
    BackgroundLayerType.topBgPlanet,
    BackgroundLayerType.topRightPlanet,
    BackgroundLayerType.topLeftPlanet,
    BackgroundLayerType.bottomLeftPlanet,
    BackgroundLayerType.bottomRightPlanet,
  ];

  static List<BackgroundLayerLayout> getLayers(BuildContext context) {
    return List.generate(
      backgroundLayerTypes.length,
      (i) => BackgroundLayerLayout(context, type: backgroundLayerTypes[i]),
    );
  }
}
