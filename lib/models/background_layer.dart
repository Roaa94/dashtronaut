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
  BuildContext context;
  BackgroundLayerType type;

  BackgroundLayer(
    this.context, {
    required this.type,
  });

  String get assetUrl => 'assets/images/background/${type.name}.png';

  Size get size {
    switch (type) {
      case BackgroundLayerType.topRightPlanet:
        return const Size(356, 241);
      case BackgroundLayerType.topLeftPlanet:
        return const Size(144, 142);
      case BackgroundLayerType.topBgPlanet:
        return const Size(63, 63);
      case BackgroundLayerType.bottomLeftPlanet:
        return const Size(276, 196);
      case BackgroundLayerType.bottomRightPlanet:
        return const Size(275, 216);
      case BackgroundLayerType.bottomBgPlanet:
        return const Size(112, 104);
      default:
        return Size.zero;
    }
  }

  Position get position {
    late Position _position;

    switch (type) {
      case BackgroundLayerType.topRightPlanet:
        _position = Position(right: -size.width * 0.36, top: -size.height * 0.08);
        break;
      case BackgroundLayerType.topLeftPlanet:
        _position = Position(left: -size.width * 0.28, top: -size.height * 0.2);
        break;
      case BackgroundLayerType.topBgPlanet:
        _position = Position(right: size.width * 2.08, top: size.height * 1.74);
        break;
      case BackgroundLayerType.bottomLeftPlanet:
        _position = Position(left: -size.width * 0.42, bottom: 0);
        break;
      case BackgroundLayerType.bottomRightPlanet:
        _position = Position(right: -size.width * 0.4, bottom: -size.height * 0.30);
        break;
      case BackgroundLayerType.bottomBgPlanet:
        _position = Position(right: size.width * 0.6, bottom: size.height * 0.8);
        break;
      default:
        _position = const Position.zero();
        break;
    }
    return _position;
  }

  @override
  String toString() => 'BackgroundLayer(type: ${type.name}, size: $size, position: $position, assetUrl: $assetUrl)';
}
