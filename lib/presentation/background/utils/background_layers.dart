import 'package:Dashtronaut/presentation/background/widgets/background_stack.dart';
import 'package:Dashtronaut/presentation/layout/background_layer_layout.dart';
import 'package:flutter/material.dart';

/// Helper class that handles background layers
class BackgroundLayers {
  /// List of background layers based on their type
  ///
  /// The order of this list determines the z-index order
  /// in which they are laid out in the Stack [BackgroundStack]
  static List<BackgroundLayerType> types = [
    BackgroundLayerType.topBgPlanet,
    BackgroundLayerType.topRightPlanet,
    BackgroundLayerType.topLeftPlanet,
    BackgroundLayerType.bottomLeftPlanet,
    BackgroundLayerType.bottomRightPlanet,
  ];

  /// Get Background layers to layout in [BackgroundStack]
  ///
  /// Generate a [BackgroundLayerLayout] from each background layer
  /// And assign it its [BackgroundLayerType] and [BuildContext]
  List<BackgroundLayerLayout> call(BuildContext context) {
    return List.generate(
      types.length,
      (i) => BackgroundLayerLayout(context, type: types[i]),
    );
  }
}
