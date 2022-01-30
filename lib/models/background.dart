import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/background_layer.dart';
import 'package:flutter_puzzle_hack/models/position.dart';

class Background {
  static const int totalStarsCount = 300;

  static List<String> layerUrls = getLayers().map((backgroundLayer) => backgroundLayer.assetUrl).toList();

  static List<BackgroundLayer> getLayers([Size screenSize = const Size(0, 0)]) {
    return [
      BackgroundLayer(
        assetUrl: 'assets/images/background/blue-lights-and-waves.png',
        position: const Position(left: 0, top: 200),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/scattered-stars-1.png',
        position: const Position(left: 0, top: 0),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/scattered-stars-2.png',
        position: const Position(left: 0, top: 300),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/bottom-stars.png',
        position: Position(left: 0, top: screenSize.height - 200),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/top-stars.png',
        position: const Position(left: 0, top: -40),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/moons.png',
        position: const Position(left: 10, top: 120),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/bottom-left-planet.png',
        position: Position(left: -150, top: screenSize.height - 250),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/big-planet.png',
        position: const Position(left: 100, top: -50),
      ),
    ];
  }
}
