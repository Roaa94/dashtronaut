import 'dart:async';
import 'dart:io';

import 'package:Dashtronaut/helpers/background_helper.dart';
import 'package:Dashtronaut/models/puzzle.dart';
import 'package:Dashtronaut/presentation/providers/app_providers.dart';
import 'package:Dashtronaut/presentation/providers/settings_provider.dart';
import 'package:Dashtronaut/presentation/styles/app_text_styles.dart';
import 'package:Dashtronaut/services/service_locator.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'presentation/home/home_page.dart';

void main() {
  setupServiceLocator();
  runZonedGuarded<Future<void>>(() async {
    await SettingsProvider().bootActions();
    runApp(const MyApp());
  }, (e, _) => throw e);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    BackgroundHelper.precacheBackgroundLayerImages(context);

    for (int size in Puzzle.supportedPuzzleSizes) {
      precacheImage(
        Image.asset('assets/images/puzzle-solved/solved-${size}x$size.png').image,
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
      providers: AppProviders.changeNotifierProviders,
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
