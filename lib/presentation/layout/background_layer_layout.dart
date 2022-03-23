import 'package:Dashtronaut/models/position.dart';
import 'package:Dashtronaut/presentation/layout/layout_delegate.dart';
import 'package:Dashtronaut/presentation/layout/screen_type_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

enum BackgroundLayerType {
  topRightPlanet,
  topLeftPlanet,
  topBgPlanet,
  bottomLeftPlanet,
  bottomRightPlanet,
  bottomBgPlanet,
}

class BackgroundLayerLayout implements LayoutDelegate {
  @override
  final BuildContext context;

  final BackgroundLayerType type;

  const BackgroundLayerLayout(
    this.context, {
    required this.type,
  });

  String get assetUrl => 'assets/images/background/${type.name}.png';

  @override
  ScreenTypeHelper get screenTypeHelper => ScreenTypeHelper(context);

  bool get landscapeMode =>
      MediaQuery.of(context).orientation == Orientation.landscape &&
      !kIsWeb &&
      MediaQuery.of(context).size.width <
          ScreenTypeHelper.breakpoints[ScreenType.medium]!;

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

    switch (screenTypeHelper.type) {
      case ScreenType.xSmall:
        _size = _size * 0.8;
        break;
      case ScreenType.small:
        _size = _size * 0.9;
        break;
      case ScreenType.medium:
        if (landscapeMode) {
          _size = _size * 1;
        } else {
          _size = _size * 1.2;
        }
        break;
      case ScreenType.large:
        if (landscapeMode) {
          _size = _size * 0.9;
        } else {
          _size = _size * 2;
        }
        break;
    }
    return _size;
  }

  Position get outOfViewPosition {
    double _extraSpace = 10;

    switch (type) {
      case BackgroundLayerType.topRightPlanet:
      case BackgroundLayerType.topBgPlanet:
        return Position(
            right: -(size.width + _extraSpace),
            top: -(size.height + _extraSpace));
      case BackgroundLayerType.topLeftPlanet:
        return Position(
            left: -(size.width + _extraSpace),
            top: -(size.height + _extraSpace));
      case BackgroundLayerType.bottomLeftPlanet:
      case BackgroundLayerType.bottomBgPlanet:
        return Position(
            left: -(size.width + _extraSpace),
            bottom: -(size.height + _extraSpace));
      case BackgroundLayerType.bottomRightPlanet:
        return Position(
            right: -(size.width + _extraSpace),
            bottom: -(size.height + _extraSpace));
    }
  }

  Position get position {
    late Position _position;

    switch (type) {
      case BackgroundLayerType.topRightPlanet:
        _position =
            Position(right: -size.width * 0.36, top: -size.height * 0.08);
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
        _position =
            Position(right: -size.width * 0.45, bottom: -size.height * 0.45);
        break;
      case BackgroundLayerType.bottomBgPlanet:
        _position = Position(left: size.width * 0.6, bottom: size.height * 0.8);
        break;
      default:
        _position = const Position.zero();
        break;
    }
    return _position;
  }

  @override
  String toString() =>
      'BackgroundLayerLayout(type: ${type.name}, size: $size, position: $position, assetUrl: $assetUrl)';
}
