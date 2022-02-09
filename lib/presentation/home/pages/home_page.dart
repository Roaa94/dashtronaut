import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/home/widgets/app_drawer.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/puzzle/views/puzzle_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: ChangeNotifierProvider(
        create: (_) => PuzzleProvider(context)..generate(),
        child: const PuzzleView(),
      ),
    );
  }
}
