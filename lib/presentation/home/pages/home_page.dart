import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/constants/ui.dart';
import 'package:flutter_puzzle_hack/presentation/background/widgets/background_wrapper.dart';
import 'package:flutter_puzzle_hack/presentation/home/widgets/app_drawer.dart';
import 'package:flutter_puzzle_hack/presentation/home/widgets/drawer_button.dart';
import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:flutter_puzzle_hack/presentation/puzzle/widgets/puzzle_board.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      body: Stack(
        children: [
          const Positioned.fill(
            child: BackgroundWrapper(),
          ),
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: UI.screenHPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MenuButton(),
                  ],
                ),
              ),
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
