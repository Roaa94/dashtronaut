import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/styles/spacing.dart';
import 'package:flutter_puzzle_hack/presentation/drawer/drawer_app_info.dart';
import 'package:flutter_puzzle_hack/presentation/drawer/puzzle_size_settings.dart';
import 'package:flutter_puzzle_hack/presentation/providers/settings_provider.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_colors.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_text_styles.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double drawerStartPadding = MediaQuery.of(context).padding.left == 0 ? Spacing.md : MediaQuery.of(context).padding.left;

    return SafeArea(
      left: false,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
          child: Transform(
            transform: Matrix4.translationValues(-2, 0, 0),
            child: Container(
              width: kIsWeb || MediaQuery.of(context).orientation == Orientation.landscape ? 500 : MediaQuery.of(context).size.width * 0.8,
              margin: kIsWeb || Platform.isAndroid || Platform.isMacOS
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
                    padding: EdgeInsets.only(left: drawerStartPadding, right: Spacing.md, top: Spacing.md, bottom: Spacing.md),
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
                    padding: EdgeInsets.only(left: drawerStartPadding, right: Spacing.md, top: Spacing.md, bottom: Spacing.md),
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
