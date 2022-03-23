import 'dart:io';

import 'package:Dashtronaut/models/puzzle.dart';
import 'package:Dashtronaut/presentation/background/utils/background_layers.dart';
import 'package:Dashtronaut/presentation/home/home_page.dart';
import 'package:Dashtronaut/presentation/layout/background_layer_layout.dart';
import 'package:Dashtronaut/presentation/styles/app_text_styles.dart';
import 'package:Dashtronaut/providers/phrases_provider.dart';
import 'package:Dashtronaut/providers/puzzle_provider.dart';
import 'package:Dashtronaut/providers/stop_watch_provider.dart';
import 'package:Dashtronaut/services/storage/storage_service.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  final StorageService storageService;

  const App({
    Key? key,
    required this.storageService,
  }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    /// Precache Background layer images for better performance
    for (BackgroundLayerType layerType in BackgroundLayers.types) {
      precacheImage(
        Image.asset('assets/images/background/${layerType.name}.png').image,
        context,
      );
    }

    for (int size in Puzzle.supportedPuzzleSizes) {
      precacheImage(
        Image.asset('assets/images/puzzle-solved/solved-${size}x$size.png')
            .image,
        context,
      );
    }
    if (!kIsWeb && Platform.isMacOS) {
      DesktopWindow.getWindowSize().then((size) {
        DesktopWindow.setMinWindowSize(Size(size.height * 0.5, size.height));
      }).onError((error, stackTrace) {
        DesktopWindow.setMinWindowSize(const Size(600, 1000));
      });
    }
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PuzzleProvider(widget.storageService)..generate(),
        ),
        ChangeNotifierProvider(
          create: (_) => StopWatchProvider(widget.storageService)..init(),
        ),
        ChangeNotifierProvider(
          create: (_) => PhrasesProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dashtronaut - Slide Puzzle Game',
        darkTheme: ThemeData(
          fontFamily: AppTextStyles.secondaryFontFamily,
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
              systemNavigationBarIconBrightness: Brightness.light,
              systemNavigationBarColor: Colors.black,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(color: Colors.white, width: 2),
              ),
              fixedSize: const Size.fromHeight(50),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              primary: Colors.white.withOpacity(0.2),
            ),
          ),
        ),
        themeMode: ThemeMode.dark,
        home: const HomePage(),
      ),
    );
  }
}
