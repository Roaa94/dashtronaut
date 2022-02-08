import 'package:flutter/cupertino.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/presentation/layout/screen_type_helper.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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

  ScreenType get screenType => ScreenTypeHelper(context).type;

  Size get size {
    late Size _size;

    switch (type) {
      case BackgroundLayerType.topRightPlanet:
        _size = const Size(356, 241);
        break;
      case BackgroundLayerType.topLeftPlanet:
        _size = const Size(144, 142);
        break;
      case BackgroundLayerType.topBgPlanet:
        _size = const Size(63, 63);
        break;
      case BackgroundLayerType.bottomLeftPlanet:
        _size = const Size(276, 196);
        break;
      case BackgroundLayerType.bottomRightPlanet:
        _size = const Size(275, 216);
        break;
      case BackgroundLayerType.bottomBgPlanet:
        _size = const Size(112, 104);
        break;
      default:
        _size = Size.zero;
        break;
    }

    switch (screenType) {
      case ScreenType.xSmall:
        _size = _size * 0.8;
        break;
      case ScreenType.small:
        _size = _size * 1;
        break;
      case ScreenType.medium:
        if (MediaQuery.of(context).orientation == Orientation.landscape && !kIsWeb) {
          _size = _size * 1;
        } else {
          _size = _size * 1.2;
        }
        break;
      case ScreenType.large:
        if (MediaQuery.of(context).orientation == Orientation.landscape && !kIsWeb) {
          _size = _size * 1;
        } else {
          _size = _size * 2;
        }
        break;
    }
    return _size;
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
