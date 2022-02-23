import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

enum ScreenType {
  xSmall,
  small,
  medium,
  large,
}

class ScreenTypeHelper {
  final BuildContext context;

  ScreenTypeHelper(this.context);

  double get screenWidth => MediaQuery.of(context).size.width;

  static Map<ScreenType, double> breakpoints = {
    ScreenType.xSmall: 375,
    ScreenType.small: 576,
    ScreenType.medium: 1200,
    ScreenType.large: 1440,
  };

  bool get landscapeMode =>
      MediaQuery.of(context).orientation == Orientation.landscape &&
      !kIsWeb &&
      MediaQuery.of(context).size.height < ScreenTypeHelper.breakpoints[ScreenType.small]!;

  ScreenType get type {
    if (screenWidth <= breakpoints[ScreenType.xSmall]!) {
      return ScreenType.xSmall;
    } else if (screenWidth <= breakpoints[ScreenType.small]!) {
      return ScreenType.small;
    } else if (screenWidth <= breakpoints[ScreenType.medium]!) {
      return ScreenType.medium;
    } else {
      return ScreenType.large;
    }
  }
}
