import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/models/background_image.dart';

class BackgroundHelper {
  static List<String> layerUrls = getLayers().map((backgroundLayer) => backgroundLayer.assetUrl).toList();

  static List<BackgroundLayer> getLayers([Size screenSize = const Size(0, 0)]) {
    return [
      BackgroundLayer(
        assetUrl: 'assets/images/background/blue-lights-and-waves.png',
        transform: Matrix4.translationValues(0, 200, 0),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/scattered-stars-1.png',
        transform: Matrix4.translationValues(0, 0, 0),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/scattered-stars-2.png',
        transform: Matrix4.translationValues(0, 300, 0),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/bottom-stars.png',
        transform: Matrix4.translationValues(0, screenSize.height - 200, 0),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/top-stars.png',
        transform: Matrix4.translationValues(0, -40, 0),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/moons.png',
        transform: Matrix4.translationValues(10, 120, 0)..scale(0.6),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/bottom-left-planet.png',
        transform: Matrix4.translationValues(0, screenSize.height - 200, 0)..scale(0.5),
      ),
      BackgroundLayer(
        assetUrl: 'assets/images/background/big-planet.png',
        transform: Matrix4.translationValues(100, -50, 0),
      ),
    ];
  }
}
