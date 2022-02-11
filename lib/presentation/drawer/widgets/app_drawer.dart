import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/drawer/widgets/drawer_app_info.dart';
import 'package:flutter_puzzle_hack/presentation/drawer/widgets/puzzle_size_settings.dart';
import 'package:flutter_puzzle_hack/presentation/providers/settings_provider.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_colors.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    EdgeInsetsGeometry drawerStartPadding = MediaQuery.of(context).orientation == Orientation.landscape && !kIsWeb
        ? EdgeInsets.only(left: MediaQuery.of(context).padding.left, top: 20, bottom: 20, right: 20)
        : const EdgeInsets.all(20);

    return SafeArea(
      left: false,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
          child: Transform(
            transform: Matrix4.translationValues(-2, 0, 0),
            child: Container(
              width: kIsWeb || MediaQuery.of(context).orientation == Orientation.landscape ? 500 : MediaQuery.of(context).size.width - 100,
              margin: kIsWeb
                  ? const EdgeInsets.symmetric(vertical: 20)
                  : EdgeInsets.only(top: MediaQuery.of(context).orientation == Orientation.landscape ? MediaQuery.of(context).padding.bottom : 0),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.5),
                borderRadius: const BorderRadiusDirectional.only(topEnd: Radius.circular(15), bottomEnd: Radius.circular(15)),
                border: Border.all(width: 2, color: Colors.white),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: MediaQuery.of(context).orientation == Orientation.landscape && !kIsWeb
                        ? EdgeInsets.only(left: MediaQuery.of(context).padding.left, top: 20, bottom: 20, right: 20)
                        : const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Dashtronaut',
                          style: AppTextStyles.title,
                        ),
                        IconButton(
                          onPressed: () {
                            if (Scaffold.of(context).isDrawerOpen) {
                              Navigator.of(context).pop();
                            }
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: const [
                          PuzzleSizeSettings(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: drawerStartPadding,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.white, width: 2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer<SettingsProvider>(
                          builder: (c, settingsProvider, _) => Text(
                            'Version ${settingsProvider.appVersionText}',
                            style: AppTextStyles.bodyXs,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const DrawerAppInfo(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
