import 'package:Dashtronaut/presentation/background/widgets/background_stack.dart';
import 'package:Dashtronaut/presentation/layout/background_layer_layout.dart';
import 'package:flutter/material.dart';

/// Helper class that handles background layers
class BackgroundHelper {
  /// List of background layers based on their type
  ///
  /// The order of this list determines the z-index order
  /// in which they are laid out in the Stack [BackgroundStack]
  static List<BackgroundLayerType> backgroundLayerTypes = [
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
  static List<BackgroundLayerLayout> getLayers(BuildContext context) {
    return List.generate(
      backgroundLayerTypes.length,
      (i) => BackgroundLayerLayout(context, type: backgroundLayerTypes[i]),
    );
  }

  /// Precache Background layer images for better performance
  static void precacheBackgroundLayerImages(BuildContext context) {
    for (BackgroundLayerType layerType in backgroundLayerTypes) {
      precacheImage(
        Image.asset('assets/images/background/${layerType.name}.png').image,
        context,
      );
    }
  }
}
