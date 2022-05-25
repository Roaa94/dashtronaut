import 'package:dashtronaut/presentation/background/utils/background_layers.dart';
import 'package:dashtronaut/presentation/background/widgets/animated_background_layer.dart';
import 'package:dashtronaut/presentation/background/widgets/stars.dart';
import 'package:dashtronaut/presentation/layout/background_layer_layout.dart';
import 'package:dashtronaut/presentation/styles/app_colors.dart';
import 'package:flutter/material.dart';

class BackgroundStack extends StatelessWidget {
  const BackgroundStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    List<BackgroundLayerLayout> backgroundLayers = BackgroundLayers()(context);

    return Positioned.fill(
      child: Container(
        height: screenSize.height,
        width: screenSize.width,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [AppColors.primaryAccent, AppColors.primary],
            stops: [0, 1],
            radius: 1.1,
            center: Alignment.centerLeft,
          ),
        ),
        child: Stack(
          children: [
            const Positioned.fill(child: Stars()),
            ...List.generate(
              backgroundLayers.length,
              (i) => AnimatedBackgroundLayer(layer: backgroundLayers[i]),
            ),
          ],
        ),
      ),
    );
  }
}
