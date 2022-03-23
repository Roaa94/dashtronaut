import 'package:Dashtronaut/presentation/layout/screen_type_helper.dart';
import 'package:flutter/cupertino.dart';

abstract class LayoutDelegate {
  final BuildContext context;

  const LayoutDelegate(this.context);

  ScreenTypeHelper get screenTypeHelper;
}
