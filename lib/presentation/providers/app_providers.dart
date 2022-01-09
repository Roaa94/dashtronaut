import 'package:flutter_puzzle_hack/presentation/providers/puzzle_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  static final changeNotifierProviders = <SingleChildWidget>[
    ChangeNotifierProvider(
      create: (_) => PuzzleProvider(),
    ),
  ];
}