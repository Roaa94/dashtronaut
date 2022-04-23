import 'package:dashtronaut/presentation/drawer/app_drawer.dart';
import 'package:dashtronaut/presentation/puzzle/ui/puzzle_view.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      drawer: AppDrawer(),
      body: PuzzleView(),
    );
  }
}
