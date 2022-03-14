import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Stars',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xff3f218d), Color(0xff180026)],
            stops: [0, 1],
            radius: 1.1,
            center: Alignment.centerLeft,
          ),
        ),
        child: const Stars(),
      ),
    );
  }
}

class StarsLayout {
  final BuildContext context;

  StarsLayout(this.context);

  Size get screenSize => MediaQuery.of(context).size;

  // Stars count changes based on screen width
  int get totalStarsCount {
    if (screenSize.width > 576) {
      return 600;
    } else if (screenSize.width > 1200) {
      return 800;
    } else if (screenSize.width > 1440) {
      return 1000;
    } else {
      return 400;
    }
  }

  final Random random = Random();

  int get starsMaxXOffset {
    // Sometimes when the context is not accessible yet,
    // the screen size might have a negative or 0 value,
    // which throws an error if given to the Random.nextInt()'s max param
    return screenSize.width.ceil() <= 0 ? 1 : screenSize.width.ceil();
  }

  int get starsMaxYOffset {
    // Sometimes when the context is not accessible yet,
    // the screen size might have a negative or 0 value,
    // which throws an error if given to the Random.nextInt()'s max param
    return screenSize.height.ceil() <= 0 ? 1 : screenSize.height.ceil();
  }

  List<int> _getRandomStarsOffsetsList(int max) {
    return List.generate(totalStarsCount, (i) => random.nextInt(max));
  }

  List<int> get randomStarXOffsets {
    return _getRandomStarsOffsetsList(starsMaxXOffset);
  }

  List<int> get randomStarYOffsets {
   return _getRandomStarsOffsetsList(starsMaxYOffset);
  }

  List<double> get randomStarSizes {
    return List.generate(totalStarsCount, (i) => random.nextDouble() + 0.7);
  }

  List<int> get fadeOutStarIndices {
    List<int> _indices = [];
    for (int i = 0; i <= totalStarsCount; i++) {
      if (i % 5 == 0) {
        _indices.add(i);
      }
    }
    return _indices;
  }

  List<int> get fadeInStarIndices {
    List<int> _indices = [];
    for (int i = 0; i <= totalStarsCount; i++) {
      if (i % 3 == 0) {
        _indices.add(i);
      }
    }
    return _indices;
  }

  CustomPainter getPainter({required Animation<double> opacity}) {
    return StarsPainter(
      xOffsets: randomStarXOffsets,
      yOffsets: randomStarYOffsets,
      sizes: randomStarSizes,
      fadeOutStarIndices: fadeOutStarIndices,
      fadeInStarIndices: fadeInStarIndices,
      totalStarsCount: totalStarsCount,
      opacityAnimation: opacity,
    );
  }
}

class StarsPainter extends CustomPainter {
  final List<int> xOffsets;
  final List<int> yOffsets;
  final List<int> fadeOutStarIndices;
  final List<int> fadeInStarIndices;
  final List<double> sizes;
  final Animation<double> opacityAnimation;
  final int totalStarsCount;

  StarsPainter({
    required this.xOffsets,
    required this.yOffsets,
    required this.fadeOutStarIndices,
    required this.fadeInStarIndices,
    required this.sizes,
    required this.opacityAnimation,
    required this.totalStarsCount,
  }) : super(repaint: opacityAnimation);

  final Paint _paint = Paint();

  double _getStarOpacity(int i) {
    if (fadeOutStarIndices.contains(i)) {
      return opacityAnimation.value;
    } else if (fadeInStarIndices.contains(i)) {
      return 1 - opacityAnimation.value;
    } else {
      return 0.5;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < totalStarsCount; i++) {
      _paint.color = Colors.white.withOpacity(_getStarOpacity(i));
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

class Stars extends StatefulWidget {
  const Stars({Key? key}) : super(key: key);

  @override
  _StarsState createState() => _StarsState();
}

class _StarsState extends State<Stars> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _opacity;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.repeat(reverse: true);

    _opacity = Tween<double>(begin: 0.8, end: 0.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StarsLayout _starsLayer = StarsLayout(context);

    return CustomPaint(
      painter: _starsLayer.getPainter(
        opacity: _opacity,
      ),
    );
  }
}