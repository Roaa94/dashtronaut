import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_puzzle_hack/models/background.dart';
import 'package:flutter_puzzle_hack/models/background_layer.dart';
import 'package:flutter_puzzle_hack/presentation/providers/settings_provider.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

import 'presentation/home/pages/home_page.dart';

void main() {
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
    for (BackgroundLayerType layerType in Background.backgroundLayerTypes) {
      precacheImage(
        Image.asset('assets/images/background/${layerType.name}.png').image,
        context,
      );
    }
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
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
