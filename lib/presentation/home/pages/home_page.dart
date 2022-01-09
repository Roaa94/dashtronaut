import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/puzzle/widgets/puzzle_board.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: const PuzzleBoard(),
    );
  }
}
