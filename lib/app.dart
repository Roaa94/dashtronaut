import 'dart:io';

import 'package:dashtronaut/core/constants.dart';
import 'package:dashtronaut/background/utils/background_layers.dart';
import 'package:dashtronaut/core/styles/app_themes.dart';
import 'package:dashtronaut/home/home_page.dart';
import 'package:dashtronaut/core/layout/background_layer_layout.dart';
import 'package:dashtronaut/dash/providers/phrases_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    hide ChangeNotifierProvider;
import 'package:provider/provider.dart';

class DashtronautApp extends ConsumerStatefulWidget {
  const DashtronautApp({super.key});

  @override
  ConsumerState<DashtronautApp> createState() => _DashtronautAppState();
}

class _DashtronautAppState extends ConsumerState<DashtronautApp> {
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PhrasesProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dashtronaut - Slide Puzzle Game',
        darkTheme: AppThemes.dark,
        themeMode: ThemeMode.dark,
        home: const HomePage(),
      ),
    );
  }
}
