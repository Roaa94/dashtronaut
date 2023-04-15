import 'dart:async';

import 'package:dashtronaut/configs/models/configs.dart';
import 'package:dashtronaut/configs/providers/configs_provider.dart';
import 'package:dashtronaut/core/services/storage/storage.dart';
import 'package:dashtronaut/core/styles/app_themes.dart';
import 'package:dashtronaut/puzzle/models/location.dart';
import 'package:dashtronaut/puzzle/models/tile.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_is_solved_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_moves_count_provider.dart';
import 'package:dashtronaut/puzzle/providers/puzzle_size_provider.dart';
import 'package:dashtronaut/puzzle/providers/tiles_provider.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_board.dart';
import 'package:dashtronaut/puzzle/widgets/solved_puzzle_dialog.dart';
import 'package:dashtronaut/puzzle/widgets/tile/puzzle_tile.dart';
import 'package:dashtronaut/widgetbook/fake_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:widgetbook/widgetbook.dart';

void main() {
  runZonedGuarded<Future<void>>(
    () async {
      // Todo: use appBuilder instead
      runApp(
        ProviderScope(
          overrides: [
            storageServiceProvider.overrideWithValue(FakeStorageService()),
          ],
          child: const DashtronautWidgetbook(),
        ),
      );

      // runApp(
      //   DashtronautWidgetbook(
      //     storageService: initializedStorageService,
      //   ),
      // );
    },
    // ignore: only_throw_errors
    (e, _) => throw e,
  );
}

// Todo: figure out the issue with ProviderScope throwing when updated
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
        // FrameAddon(
        //   setting: FrameSetting.firstAsSelected(
        //     frames: [
        //       WidgetbookFrame(
        //         setting: DeviceSetting.firstAsSelected(
        //           devices: [
        //             Apple.iPhone12,
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
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
          name: 'Puzzle Board',
          children: [
            WidgetbookComponent(
              name: 'PuzzleBoard',
              useCases: [
                WidgetbookUseCase(
                  name: '3x3 Puzzle',
                  builder: puzzleBoard3x3,
                ),
                WidgetbookUseCase(
                  name: '4x4 Puzzle',
                  builder: puzzleBoard4x4,
                ),
                WidgetbookUseCase(
                  name: '5x5 Puzzle',
                  builder: puzzleBoard5x5,
                ),
                WidgetbookUseCase(
                  name: '6x6 Puzzle',
                  builder: puzzleBoard6x6,
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'PuzzleTile',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: puzzleTile,
                )
              ],
            ),
          ],
        ),
        const WidgetbookCategory(
          name: 'Puzzle Solved',
          children: [
            WidgetbookComponent(
              name: 'Puzzle Solved Dialog',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: puzzleSolvedDialog,
                ),
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

Widget puzzleBoard3x3(BuildContext context) {
  return ProviderScope(
    overrides: [
      configsProvider.overrideWith(
        (_) => const Configs(
          defaultPuzzleSize: 3,
        ),
      ),
      puzzleSizeProvider,
      tilesProvider,
      puzzleIsSolvedProvider,
    ],
    child: const Center(
      child: PuzzleBoard(),
    ),
  );
}

Widget puzzleBoard4x4(BuildContext context) {
  return const Center(
    child: PuzzleBoard(),
  );
}

Widget puzzleBoard5x5(BuildContext context) {
  return ProviderScope(
    parent: ProviderScope.containerOf(context),
    overrides: [
      configsProvider.overrideWith(
        (_) => const Configs(
          defaultPuzzleSize: 5,
        ),
      ),
      puzzleSizeProvider,
      tilesProvider,
      puzzleIsSolvedProvider,
    ],
    child: const Center(
      child: PuzzleBoard(),
    ),
  );
}

Widget puzzleBoard6x6(BuildContext context) {
  return ProviderScope(
    overrides: [
      configsProvider.overrideWith(
        (_) => const Configs(
          defaultPuzzleSize: 6,
        ),
      ),
      puzzleSizeProvider,
      tilesProvider,
      puzzleIsSolvedProvider,
      puzzleMovesCountProvider,
    ],
    child: const Center(
      child: PuzzleBoard(),
    ),
  );
}

Widget puzzleTile(BuildContext context) {
  final size = context.knobs.slider(
    label: 'Size',
    min: 100,
    max: 400,
    divisions: 300,
    initialValue: 150,
  );

  return Center(
    child: SizedBox(
      width: size,
      height: size,
      child: PuzzleTile(
        isMovable: context.knobs.boolean(
          label: 'Is the Tile Movable?',
          description:
              'Movable tiles (tiles around white space), will pulse continuously',
        ),
        isPuzzleSolved: context.knobs.boolean(
          label: 'Is Puzzle Solved?',
          description: 'If the puzzle is solved, hovering over '
              'the tile should not animate it',
        ),
        tile: Tile(
          currentLocation: Location(
            x: context.knobs.boolean(
              label: 'Is Tile at Correct Location?',
              description: 'This will run the Rive animation',
            )
                ? 2
                : 3,
            y: 1,
          ),
          correctLocation: const Location(x: 2, y: 1),
          value: context.knobs
              .slider(
                label: 'Tile Value',
                divisions: 9,
                max: 9,
                min: 1,
                initialValue: 1,
              )
              .toInt(),
        ),
        puzzleSize: 3,
      ),
    ),
  );
}

Widget puzzleSolvedDialog(BuildContext context) {
  return SolvedPuzzleDialog(
    puzzleSize: context.knobs.options<int>(
      label: 'Puzzle Size',
      labelBuilder: (value) => '${value}x$value',
      options: [3, 4, 5, 6],
    ),
    solvingDuration: Duration(
      seconds: context.knobs
          .slider(
            label: 'Solving duration in seconds',
            initialValue: 20,
            min: 10,
            max: 2000,
            divisions: 200,
          )
          .toInt(),
    ),
    movesCount: context.knobs
        .slider(
          label: 'Moves Count',
          initialValue: 20,
          min: 10,
          max: 2000,
          divisions: 200,
        )
        .toInt(),
    isWeb: false,
    onSharePressed: () {},
    onRestartPressed: () {},
  );
}

Widget puzzleSolvedDialog3x3(BuildContext context) {
  return SolvedPuzzleDialog(
    puzzleSize: 3,
    solvingDuration: const Duration(seconds: 20),
    movesCount: 20,
    isWeb: false,
    onSharePressed: () {},
    onRestartPressed: () {},
  );
}

Widget puzzleSolvedDialog4x4(BuildContext context) {
  return SolvedPuzzleDialog(
    puzzleSize: 4,
    solvingDuration: const Duration(seconds: 20),
    movesCount: 20,
    isWeb: false,
    onSharePressed: () {},
    onRestartPressed: () {},
  );
}

Widget puzzleSolvedDialog5x5(BuildContext context) {
  return SolvedPuzzleDialog(
    puzzleSize: 5,
    solvingDuration: const Duration(seconds: 20),
    movesCount: 20,
    isWeb: false,
    onSharePressed: () {},
    onRestartPressed: () {},
  );
}

Widget puzzleSolvedDialog6x6(BuildContext context) {
  return SolvedPuzzleDialog(
    puzzleSize: 6,
    solvingDuration: const Duration(seconds: 20),
    movesCount: 20,
    isWeb: false,
    onSharePressed: () {},
    onRestartPressed: () {},
  );
}
