import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/providers/app_providers.dart';
import 'package:provider/provider.dart';

import 'presentation/home/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProviders.changeNotifierProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Puzzle Hack',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}
