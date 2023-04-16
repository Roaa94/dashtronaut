import 'package:dashtronaut/core/constants.dart';
import 'package:dashtronaut/background/utils/background_layers.dart';
import 'package:dashtronaut/core/styles/app_themes.dart';
import 'package:dashtronaut/home/home_page.dart';
import 'package:dashtronaut/core/layout/background_layer_layout.dart';
import 'package:flutter/material.dart';

class DashtronautApp extends StatefulWidget {
  const DashtronautApp({super.key});

  @override
  State<DashtronautApp> createState() => _DashtronautAppState();
}

class _DashtronautAppState extends State<DashtronautApp> {
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      for (BackgroundLayerType layerType in BackgroundLayers.types) {
        precacheImage(
          Image.asset('assets/images/background/${layerType.name}.png').image,
          context,
        );
      }

      for (int size in Constants.supportedPuzzleSizes) {
        precacheImage(
          Image.asset('assets/images/puzzle-solved/solved-${size}x$size.png')
              .image,
          context,
        );
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dashtronaut - Slide Puzzle Game',
      darkTheme: AppThemes.dark,
      themeMode: ThemeMode.dark,
      home: const HomePage(),
    );
  }
}
