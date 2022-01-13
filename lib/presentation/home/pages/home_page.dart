import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/background/widgets/background.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/puzzle/widgets/puzzle_board.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PuzzleProvider(context)..generate(),
      child: Scaffold(
        body: Stack(
          children: const [
            Positioned.fill(child: Background()),
            PuzzleBoard(),
          ],
        ),
      ),
    );
  }
}
