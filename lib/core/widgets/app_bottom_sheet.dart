import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:synk/core/app_colors.dart';
import 'package:synk/core/constants/app_spacing.dart';
import 'package:synk/core/widgets/button.dart';

class AppBottomSheetItem {
  final IconData icon;
  final String text;

  const AppBottomSheetItem({required this.icon, required this.text});
}

class AppBottomSheet extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String description;
  final List<AppBottomSheetItem> items;
  final String buttonText;
  final VoidCallback? onPressed;

  const AppBottomSheet({
    super.key,
    this.icon,
    required this.title,
    required this.description,
    this.items = const [],
    this.buttonText = 'Continue',
    this.onPressed,
  });

  /// Shows this bottom sheet as a modal. Returns when dismissed.
  static Future<void> show(
    BuildContext context, {
    Widget? icon,
    required String title,
    required String description,
    List<AppBottomSheetItem> items = const [],
    String buttonText = 'Continue',
    VoidCallback? onPressed,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet(
      context: context,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      backgroundColor: Colors.transparent,
      builder: (_) => AppBottomSheet(
        icon: icon,
        title: title,
        description: description,
        items: items,
        buttonText: buttonText,
        onPressed: onPressed ?? () => Navigator.pop(context),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[icon!, AppSpacing.h16],
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: GoogleFonts.inter().fontFamily,
              color: AppColors.textPrimary,
            ),
          ),
          AppSpacing.h8,
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              fontFamily: GoogleFonts.inter().fontFamily,
              color: AppColors.textTertiary,
              height: 1.4,
            ),
          ),
          if (items.isNotEmpty) ...[
            AppSpacing.h16,
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(item.icon, size: 20, color: AppColors.textPrimary),
                    AppSpacing.w12,
                    Expanded(
                      child: Text(
                        item.text,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          color: AppColors.textTertiary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          AppSpacing.h24,
          Button(
            text: buttonText,
            onPressed: onPressed ?? () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
