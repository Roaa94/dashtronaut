import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/background_layer.dart';
import 'package:flutter_puzzle_hack/models/position.dart';

class Background {
  static const int totalStarsCount = 200;

  static List<String> layerUrls = getLayers().map((backgroundLayer) => backgroundLayer.assetUrl).toList();

  static List<BackgroundLayer> getLayers([Size screenSize = const Size(0, 0)]) {
    return [
      BackgroundLayer(
        assetUrl: 'assets/images/background/moons.png',
        position: const Position(left: -70, top: 90),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/bottom-left-planet.png',
        position: Position(left: -150, top: screenSize.height - 250),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/big-planet.png',
        position: Position(left: screenSize.width - 270, top: -80),
      ),
    ];
  }
}
