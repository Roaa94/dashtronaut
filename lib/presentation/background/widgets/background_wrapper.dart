import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/background.dart';
import 'package:flutter_puzzle_hack/models/background_layer.dart';
import 'package:flutter_puzzle_hack/presentation/background/widgets/animated_background_layer.dart';
import 'package:flutter_puzzle_hack/presentation/background/widgets/stars.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_colors.dart';

class BackgroundWrapper extends StatelessWidget {
  const BackgroundWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    List<BackgroundLayer> _backgroundLayers = Background.getLayers(context);

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
              _backgroundLayers.length,
              (i) => AnimatedBackgroundLayer(layer: _backgroundLayers[i]),
            ),
          ],
        ),
      ),
    );
  }
}
