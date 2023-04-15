import 'dart:async';

import 'package:dashtronaut/configs/models/configs.dart';
import 'package:dashtronaut/configs/providers/configs_provider.dart';
import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:dashtronaut/core/styles/app_themes.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/puzzle/widgets/solved_puzzle_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:dashtronaut/core/services/share-score/share_score_service.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      // Hive-specific initialization
      await Hive.initFlutter();
      final StorageService initializedStorageService = HiveStorageService();
      await initializedStorageService.init();
      await initializedStorageService.clear();

      runApp(
        ProviderScope(
          overrides: [
            storageServiceProvider.overrideWithValue(initializedStorageService),
          ],
          child: const DashtronautWidgetbook(),
        ),
      );
    },
    // ignore: only_throw_errors
    (e, _) => throw e,
  );
}

class DashtronautWidgetbook extends StatelessWidget {
  const DashtronautWidgetbook({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        CustomThemeAddon(
          setting: ThemeSetting.firstAsSelected(
            themes: [
              WidgetbookTheme(
                name: 'Dark',
                data: AppThemes.dark,
              ),
            ],
          ),
        ),
        FrameAddon(
          setting: FrameSetting.firstAsSelected(
            frames: [
              WidgetbookFrame(
                setting: DeviceSetting.firstAsSelected(
                  devices: [
                    Apple.iPhone12,
                  ],
                ),
              ),
            ],
          ),
        ),
        LocalizationAddon(
          setting: LocalizationSetting.firstAsSelected(
            locales: [const Locale('en')],
            localizationsDelegates: [DefaultMaterialLocalizations.delegate],
          ),
        ),
        TextScaleAddon(
          setting: TextScaleSetting.firstAsSelected(textScales: [1, 1.5, 2]),
        ),
      ],
      directories: [
        const WidgetbookCategory(
          name: 'Puzzle Solved',
          children: [
            WidgetbookComponent(
              name: 'Puzzle Solved Dialog',
              useCases: [
                WidgetbookUseCase(
                  name: '3x3 Puzzle',
                  builder: puzzleSolvedDialog3x3,
                ),
                WidgetbookUseCase(
                  name: '4x4 Puzzle',
                  builder: puzzleSolvedDialog4x4,
                ),
                WidgetbookUseCase(
                  name: '5x5 Puzzle',
                  builder: puzzleSolvedDialog5x5,
                ),
                WidgetbookUseCase(
                  name: '6x6 Puzzle',
                  builder: puzzleSolvedDialog6x6,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

Widget puzzleSolvedDialog3x3(BuildContext context) {
  return ProviderScope(
    overrides: [
      configsProvider.overrideWith(
        (_) => const Configs(
          defaultPuzzleSize: 3,
        ),
      ),
      puzzleSizeProvider,
      shareScoreServiceProvider,
    ],
    child: const SolvedPuzzleDialog(
      solvingDuration: Duration(seconds: 20),
    ),
  );
}

Widget puzzleSolvedDialog4x4(BuildContext context) {
  return ProviderScope(
    overrides: [
      configsProvider.overrideWith(
        (_) => const Configs(
          defaultPuzzleSize: 4,
        ),
      ),
      puzzleSizeProvider,
      shareScoreServiceProvider,
    ],
    child: const SolvedPuzzleDialog(
      solvingDuration: Duration(seconds: 20),
    ),
  );
}

Widget puzzleSolvedDialog5x5(BuildContext context) {
  return ProviderScope(
    overrides: [
      configsProvider.overrideWith(
        (_) => const Configs(
          defaultPuzzleSize: 5,
        ),
      ),
      puzzleSizeProvider,
      shareScoreServiceProvider,
    ],
    child: const SolvedPuzzleDialog(
      solvingDuration: Duration(seconds: 20),
    ),
  );
}

Widget puzzleSolvedDialog6x6(BuildContext context) {
  return ProviderScope(
    overrides: [
      configsProvider.overrideWith(
        (_) => const Configs(
          defaultPuzzleSize: 6,
        ),
      ),
      puzzleSizeProvider,
      shareScoreServiceProvider,
    ],
    child: const SolvedPuzzleDialog(
      solvingDuration: Duration(seconds: 20),
    ),
  );
}
