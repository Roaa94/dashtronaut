import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/background.dart';
import 'package:flutter_puzzle_hack/models/background_layer.dart';
import 'package:flutter_puzzle_hack/models/position.dart';
import 'package:flutter_puzzle_hack/models/stars_layer.dart';

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
          color: Colors.black54,
          image: DecorationImage(
            image: AssetImage('assets/images/background/bg.png'),
            fit: BoxFit.cover,
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
              (i) {
                Position initialLayerPosition = _backgroundLayers[i].position;
                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 100),
                  left: initialLayerPosition.left,
                  top: initialLayerPosition.top,
                  right: initialLayerPosition.right,
                  bottom: initialLayerPosition.bottom,
                  child: Image.asset(
                    _backgroundLayers[i].assetUrl,
                    width: _backgroundLayers[i].size.width,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
