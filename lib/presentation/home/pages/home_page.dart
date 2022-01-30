import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/background/widgets/background_wrapper.dart';
import 'package:flutter_puzzle_hack/presentation/providers/background_provider.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/puzzle/widgets/puzzle_board.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ChangeNotifierProvider(
            create: (_) => BackgroundProvider(context),
            child: const Positioned.fill(
              child: BackgroundWrapper(),
            ),
          ),
          ChangeNotifierProvider(
            create: (_) => PuzzleProvider(context)..generate(),
            child: const PuzzleBoard(),
          ),
        ],
      ),
    );
  }
}
