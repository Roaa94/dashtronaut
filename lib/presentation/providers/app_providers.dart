import 'package:flutter_puzzle_hack/presentation/providers/phrases_provider.dart';
import 'package:flutter_puzzle_hack/presentation/providers/settings_provider.dart';
import 'package:flutter_puzzle_hack/presentation/providers/stop_watch_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  static final changeNotifierProviders = <SingleChildWidget>[
    ChangeNotifierProvider(create: (_) => SettingsProvider()),
    ChangeNotifierProvider(create: (_) => StopWatchProvider()),
    ChangeNotifierProvider(create: (_) => PhrasesProvider()),
  ];
}
