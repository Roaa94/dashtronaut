import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/background_layer.dart';
import 'package:flutter_puzzle_hack/models/position.dart';

class Background {
  static const int totalStarsCount = 300;

  static List<BackgroundLayerType> backgroundLayerTypes = [
    BackgroundLayerType.topRightPlanet,
    BackgroundLayerType.topLeftPlanet,
    BackgroundLayerType.topBgPlanet,
    BackgroundLayerType.bottomLeftPlanet,
    BackgroundLayerType.bottomRightPlanet,
    BackgroundLayerType.bottomBgPlanet,
  ];

  static Map<BackgroundLayerType, String> backgroundLayerAssetUrls = {
    BackgroundLayerType.topRightPlanet: 'assets/images/background/top-right-planet.png',
    BackgroundLayerType.topLeftPlanet: 'assets/images/background/top-left-planet.png',
    BackgroundLayerType.topBgPlanet: 'assets/images/background/top-bg-planet.png',
    BackgroundLayerType.bottomLeftPlanet: 'assets/images/background/bottom-left-planet.png',
    BackgroundLayerType.bottomRightPlanet: 'assets/images/background/bottom-bg-planet.png',
    BackgroundLayerType.bottomBgPlanet: 'assets/images/background/bottom-right-planet.png',
  };

  static Size getLayerSize(Size screenSize, BackgroundLayerType type, {bool flipped = false}) {
    Size _dynamicScreenSize = flipped ? screenSize.flipped : screenSize;

    switch (type) {
      case BackgroundLayerType.topRightPlanet:
        return Size(_dynamicScreenSize.width * 0.9, _dynamicScreenSize.height * 0.3);
      case BackgroundLayerType.topLeftPlanet:
        return Size(_dynamicScreenSize.width * 0.36, _dynamicScreenSize.height * 0.16);
      case BackgroundLayerType.topBgPlanet:
        return Size(_dynamicScreenSize.width * 0.16, _dynamicScreenSize.height * 0.16);
      case BackgroundLayerType.bottomLeftPlanet:
        return Size(_dynamicScreenSize.width * 0.7, _dynamicScreenSize.height * 0.23);
      case BackgroundLayerType.bottomRightPlanet:
        return Size(_dynamicScreenSize.width * 0.28, _dynamicScreenSize.height * 0.25);
      case BackgroundLayerType.bottomBgPlanet:
        return Size(_dynamicScreenSize.width * 0.7, _dynamicScreenSize.height * 0.25);
      default:
        return Size.zero;
    }
  }

  static Position getLayerPosition(Size screenSize, BackgroundLayerType type) {
    switch (type) {
      case BackgroundLayerType.topRightPlanet:
        return Position(left: screenSize.width * 0.4, top: -screenSize.height * 0.031);
      case BackgroundLayerType.topLeftPlanet:
        return Position(left: -screenSize.width * 0.15, top: -screenSize.height * 0.06);
      case BackgroundLayerType.topBgPlanet:
        return Position(left: screenSize.width * 0.5, top: screenSize.height * 0.13);
      case BackgroundLayerType.bottomLeftPlanet:
        return Position(left: -screenSize.width * 0.3, top: screenSize.height * 0.75);
      case BackgroundLayerType.bottomRightPlanet:
        return Position(left: screenSize.width * 0.56, top: screenSize.height * 0.8);
      case BackgroundLayerType.bottomBgPlanet:
        return Position(left: screenSize.width * 0.63, top: screenSize.height * 0.8);
    }
  }

  static List<BackgroundLayer> getLayers(Size screenSize, Orientation screenOrientation) {
    return List.generate(
      backgroundLayerTypes.length,
      (i) {
        Size layerSize = getLayerSize(screenSize, backgroundLayerTypes[i], flipped: screenOrientation == Orientation.landscape);
        Position layerPosition = getLayerPosition(screenSize, backgroundLayerTypes[i]);

        return BackgroundLayer(
          type: backgroundLayerTypes[i],
          assetUrl: backgroundLayerAssetUrls[backgroundLayerTypes[i]]!,
          size: layerSize,
          position: layerPosition,
        );
      },
    );
  }
}
