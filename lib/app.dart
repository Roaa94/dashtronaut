import 'dart:io';

import 'package:dashtronaut/core/constants.dart';
import 'package:dashtronaut/background/utils/background_layers.dart';
import 'package:dashtronaut/core/styles/app_themes.dart';
import 'package:dashtronaut/home/home_page.dart';
import 'package:dashtronaut/core/layout/background_layer_layout.dart';
import 'package:dashtronaut/dash/providers/phrases_provider.dart';
import 'package:dashtronaut/puzzle/providers/old_puzzle_provider.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'
    hide ChangeNotifierProvider;
import 'package:provider/provider.dart';
import 'package:dashtronaut/core/services/storage/storage.dart';

class DashtronautApp extends ConsumerStatefulWidget {
  const DashtronautApp({super.key});

  @override
  ConsumerState<DashtronautApp> createState() => _DashtronautAppState();
}

class _DashtronautAppState extends ConsumerState<DashtronautApp> {
  @override
  void initState() {
    if (!kIsWeb && Platform.isMacOS) {
      DesktopWindow.getWindowSize().then((size) {
        DesktopWindow.setMinWindowSize(Size(size.height * 0.5, size.height));
      }).onError((error, stackTrace) {
        DesktopWindow.setMinWindowSize(const Size(600, 1000));
      });
    }
    super.initState();
  }

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
    final storageService = ref.watch(storageServiceProvider);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OldPuzzleProvider(storageService)..generate(),
        ),
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
