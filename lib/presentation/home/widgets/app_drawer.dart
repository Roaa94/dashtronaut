import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle_hack/presentation/styles/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
          child: Transform(
            transform: Matrix4.translationValues(-2, 0, 0),
            child: Container(
              width: MediaQuery.of(context).size.width - 100,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.5),
                borderRadius: const BorderRadiusDirectional.only(topEnd: Radius.circular(15), bottomEnd: Radius.circular(15)),
                border: Border.all(width: 2, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
