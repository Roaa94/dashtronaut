import 'package:dashtronaut/background/widgets/background_stack.dart';
import 'package:dashtronaut/core/animations/utils/animations_manager.dart';
import 'package:dashtronaut/core/animations/widgets/scale_up_transition.dart';
import 'package:dashtronaut/core/layout/screen_type_helper.dart';
import 'package:dashtronaut/core/layout/spacing.dart';
import 'package:dashtronaut/dash/widgets/dash.dart';
import 'package:dashtronaut/drawer/widgets/app_drawer_button.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_board.dart';
import 'package:dashtronaut/puzzle/widgets/puzzle_header.dart';
import 'package:dashtronaut/puzzle/widgets/reset_puzzle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PuzzleView extends ConsumerWidget {
  const PuzzleView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ScreenTypeHelper screenTypeHelper = ScreenTypeHelper(context);

    return Stack(
      children: [
        const BackgroundStack(),
        screenTypeHelper.landscapeMode
            ? _buildHorizontalPuzzleElements(context)
            : _buildVerticalPuzzleElements(context),
        // const Dash(),
      ],
    );
  }

  Widget _buildHorizontalPuzzleElements(BuildContext context) {
    final screenPadding = MediaQuery.of(context).padding;

    return Padding(
      padding: EdgeInsets.only(
        left: screenPadding.left,
        top: Spacing.screenHPadding,
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppDrawerButton(),
                SizedBox(height: 20),
                PuzzleHeader(),
                ResetPuzzleButton(),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerLeft,
              child: ScaleUpTransition(
                delay: AnimationsManager.bgLayerAnimationDuration,
                child: PuzzleBoard(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalPuzzleElements(BuildContext context) {
    final screenPadding = MediaQuery.of(context).padding;

    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: Padding(
            padding: EdgeInsetsDirectional.only(
              start: Spacing.screenHPadding,
              top: screenPadding.top == 0
                  ? Spacing.screenHPadding
                  : screenPadding.top,
            ),
            child: const AppDrawerButton(),
          ),
        ),
        Expanded(
          child: Align(
            alignment: const Alignment(0.0, -0.4),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    PuzzleHeader(),
                    ScaleUpTransition(
                      delay: AnimationsManager.bgLayerAnimationDuration,
                      child: PuzzleBoard(),
                    ),
                    ResetPuzzleButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
