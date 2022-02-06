import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/background_layer.dart';
import 'package:flutter_puzzle_hack/models/position.dart';

class Background {
  static const int totalStarsCount = 200;

  static List<String> layerUrls = getLayers().map((backgroundLayer) => backgroundLayer.assetUrl).toList();

  static List<BackgroundLayer> getLayers([Size screenSize = const Size(0, 0)]) {
    return [
      BackgroundLayer(
        assetUrl: 'assets/images/background/top-right-planet.png',
        size: Size(screenSize.width * 0.9, screenSize.height * 0.3),
        position: Position(left: screenSize.width * 0.4, top: -screenSize.height * 0.031),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/top-left-planet.png',
        size: Size(screenSize.width * 0.36, screenSize.height * 0.16),
        position: Position(left: -screenSize.width * 0.15, top: -screenSize.height * 0.06),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/top-bg-planet.png',
        size: Size(screenSize.width * 0.16, screenSize.height * 0.16),
        position: Position(left: screenSize.width * 0.5, top: screenSize.height * 0.13),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/bottom-left-planet.png',
        size: Size(screenSize.width * 0.7, screenSize.height * 0.23),
        position: Position(left: -screenSize.width * 0.3, top: screenSize.height * 0.75),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/bottom-bg-planet.png',
        size: Size(screenSize.width * 0.28, screenSize.height * 0.12),
        position: Position(left: screenSize.width * 0.56, top: screenSize.height * 0.8),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/bottom-right-planet.png',
        size: Size(screenSize.width * 0.7, screenSize.height * 0.25),
        position: Position(left: screenSize.width * 0.63, top: screenSize.height * 0.8),
      ),
    ];
  }
}
