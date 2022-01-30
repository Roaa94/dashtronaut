import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/models/background.dart';
import 'package:flutter_puzzle_hack/presentation/providers/background_provider.dart';
import 'package:provider/provider.dart';

class BackgroundWrapper extends StatefulWidget {
  const BackgroundWrapper({Key? key}) : super(key: key);

  @override
  State<BackgroundWrapper> createState() => _BackgroundState();
}

class _BackgroundState extends State<BackgroundWrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Rebuilt Background');
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.black54,
          image: DecorationImage(
            image: AssetImage('assets/images/background/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<BackgroundProvider>(
          builder: (c, backgroundProvider, _) => CustomPaint(
            painter: StarsPainter(
              xOffsets: backgroundProvider.randomStarXOffsets,
              yOffsets: backgroundProvider.randomStarYOffsets,
              sizes: backgroundProvider.randomStarSizes,
              color: Colors.white.withOpacity(0.2),
            ),
            foregroundPainter: StarsPainter(
              xOffsets: backgroundProvider.randomStarXOffsets,
              yOffsets: backgroundProvider.randomStarYOffsets,
              sizes: backgroundProvider.randomStarSizes,
            ),
          ),
        ),
      ),
    );
  }
}

class StarsPainter extends CustomPainter {
  final List<int> xOffsets;
  final List<int> yOffsets;
  final List<double> sizes;
  final Color? color;

  StarsPainter({
    required this.xOffsets,
    required this.yOffsets,
    required this.sizes,
    this.color,
  });

  final Paint _paint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = color ?? Colors.white.withOpacity(0.5);
    for (int i = 0; i <= Background.totalStarsCount; i++) {
      canvas.drawCircle(
        Offset(xOffsets[i].toDouble(), yOffsets[i].toDouble()),
        sizes[i],
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
