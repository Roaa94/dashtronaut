import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/models/background_layer.dart';
import 'package:flutter_puzzle_hack/models/vector.dart';

class BackgroundHelper {
  static List<String> layerUrls = getLayers().map((backgroundLayer) => backgroundLayer.assetUrl).toList();

  static List<BackgroundLayer> getLayers([Size screenSize = const Size(0, 0)]) {
    return [
      BackgroundLayer(
        assetUrl: 'assets/images/background/blue-lights-and-waves.png',
        vector: Vector(0, 200, 0),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/scattered-stars-1.png',
        vector: Vector(0, 0, 0),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/scattered-stars-2.png',
        vector: Vector(0, 300, 0),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/bottom-stars.png',
        vector: Vector(0, screenSize.height - 200, 0),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/top-stars.png',
        vector: Vector(0, -40, 0),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/moons.png',
        vector: Vector(10, 120, 0),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/bottom-left-planet.png',
        vector: Vector(-150, screenSize.height - 250, 0),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/big-planet.png',
        vector: Vector(100, -50, 0),
      ),
    ];
  }
}
