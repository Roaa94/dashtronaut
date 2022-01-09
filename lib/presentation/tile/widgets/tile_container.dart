import 'package:flutter/material.dart';

class TileContainer extends StatelessWidget {
  final int value;

  const TileContainer({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(5),
      alignment: Alignment.center,
      child: Text('$value'),
    );
  }
}
