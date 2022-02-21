import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/data/models/background.dart';
import 'package:flutter_puzzle_hack/data/models/background_layer.dart';
import 'package:flutter_puzzle_hack/data/models/stars_layer.dart';
import 'package:flutter_puzzle_hack/presentation/background/widgets/animated_background_layer.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_colors.dart';

class BackgroundWrapper extends StatelessWidget {
  const BackgroundWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    List<BackgroundLayer> _backgroundLayers = Background.getLayers(context);
    StarsLayer _starsLayer = StarsLayer(context);

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
            Positioned.fill(
              child: CustomPaint(
                painter: _starsLayer.getPainter(color: Colors.white.withOpacity(0.2)),
                foregroundPainter: _starsLayer.getPainter(),
              ),
            ),
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
