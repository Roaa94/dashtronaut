import 'package:flutter/material.dart';

class PuzzleHeader extends StatelessWidget {
  const PuzzleHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text('Dashtronaut', style: TextStyle(fontSize: 25)),
          Text('Solve This Slide Puzzle..'),
        ],
      ),
    );
  }
}
