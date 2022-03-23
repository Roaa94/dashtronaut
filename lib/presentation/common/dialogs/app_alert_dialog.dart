import 'dart:ui';

import 'package:Dashtronaut/presentation/layout/spacing.dart';
import 'package:Dashtronaut/presentation/styles/app_colors.dart';
import 'package:Dashtronaut/presentation/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppAlertDialog extends StatelessWidget {
  final String? title;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final Widget? content;
  final EdgeInsets insetPadding;

  const AppAlertDialog({
    Key? key,
    this.title,
    this.onConfirm,
    this.onCancel,
    this.content,
    this.insetPadding =
        const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
  })  : assert(content == null ? title != null && onConfirm != null : true),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(0),
      scrollable: true,
      insetPadding: insetPadding,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(color: Colors.white, width: 2),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 8, sigmaX: 8),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                    horizontal: Spacing.screenHPadding, vertical: Spacing.md),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: AppColors.primary.withOpacity(0.6),
                ),
                child: content ??
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (title != null)
                          Text(
                            title!,
                            style: AppTextStyles.h2.copyWith(height: 1.5),
                          ),
                        const SizedBox(height: 40),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (onConfirm != null) {
                                    onConfirm!();
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Yes'),
                              ),
                            ),
                            const SizedBox(width: Spacing.sm),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: onCancel ??
                                    () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
