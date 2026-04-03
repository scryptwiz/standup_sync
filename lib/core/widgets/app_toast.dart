import 'dart:async';

import 'package:flutter/material.dart';
import 'package:synk/core/app_colors.dart';

enum AppToastType { success, error }

class AppToast {
  static OverlayEntry? _entry;
  static Timer? _dismissTimer;

  static void show(
    BuildContext context, {
    required String message,
    required AppToastType type,
    Duration? duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    bool persistent = false,
  }) {
    hide();
    final style = _styleFor(type);
    final overlay = Overlay.of(context, rootOverlay: true);

    _entry = OverlayEntry(
      builder: (context) {
        final topInset = MediaQuery.of(context).viewPadding.top;
        return Positioned(
          top: topInset + 12,
          left: 16,
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              builder: (context, value, child) {
                return Transform.translate(
                  offset: Offset(0, -20 * (1 - value)),
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: style.background,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: style.borderColor, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: style.glowColor,
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                    const BoxShadow(
                      color: Color(0x40000000),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: style.iconBgColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        style.icon,
                        color: style.iconColor,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        message,
                        style: TextStyle(
                          color: style.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    if (actionLabel != null && onAction != null) ...[
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: onAction,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: style.actionBgColor,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: style.actionBorderColor,
                            ),
                          ),
                          child: Text(
                            actionLabel,
                            style: TextStyle(
                              color: style.actionColor,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
    overlay.insert(_entry!);

    if (!persistent && duration != null) {
      _dismissTimer = Timer(duration, hide);
    }
  }

  static void hide() {
    _dismissTimer?.cancel();
    _dismissTimer = null;
    _entry?.remove();
    _entry = null;
  }

  static void success(
    BuildContext context, {
    required String message,
    Duration? duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    bool persistent = false,
  }) {
    show(
      context,
      message: message,
      type: AppToastType.success,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      persistent: persistent,
    );
  }

  static void error(
    BuildContext context, {
    required String message,
    Duration? duration = const Duration(seconds: 4),
    String? actionLabel,
    VoidCallback? onAction,
    bool persistent = false,
  }) {
    show(
      context,
      message: message,
      type: AppToastType.error,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
      persistent: persistent,
    );
  }

  static _AppToastStyle _styleFor(AppToastType type) {
    switch (type) {
      case AppToastType.success:
        return _AppToastStyle(
          icon: Icons.wifi_rounded,
          background: AppColors.navyDeep,
          borderColor: AppColors.tealAccent.withValues(alpha: 0.25),
          glowColor: AppColors.tealAccent.withValues(alpha: 0.12),
          textColor: Colors.white.withValues(alpha: 0.9),
          iconColor: AppColors.tealAccent,
          iconBgColor: AppColors.tealAccent.withValues(alpha: 0.15),
          actionColor: AppColors.tealAccent,
          actionBgColor: AppColors.tealAccent.withValues(alpha: 0.1),
          actionBorderColor: AppColors.tealAccent.withValues(alpha: 0.25),
        );
      case AppToastType.error:
        return _AppToastStyle(
          icon: Icons.wifi_off_rounded,
          background: AppColors.navyDeep,
          borderColor: const Color(0xFFFF4444).withValues(alpha: 0.3),
          glowColor: const Color(0xFFFF4444).withValues(alpha: 0.1),
          textColor: Colors.white.withValues(alpha: 0.9),
          iconColor: const Color(0xFFFF6B6B),
          iconBgColor: const Color(0xFFFF4444).withValues(alpha: 0.12),
          actionColor: const Color(0xFFFF6B6B),
          actionBgColor: const Color(0xFFFF4444).withValues(alpha: 0.1),
          actionBorderColor: const Color(0xFFFF4444).withValues(alpha: 0.25),
        );
    }
  }
}

class _AppToastStyle {
  final IconData icon;
  final Color background;
  final Color borderColor;
  final Color glowColor;
  final Color textColor;
  final Color iconColor;
  final Color iconBgColor;
  final Color actionColor;
  final Color actionBgColor;
  final Color actionBorderColor;

  const _AppToastStyle({
    required this.icon,
    required this.background,
    required this.borderColor,
    required this.glowColor,
    required this.textColor,
    required this.iconColor,
    required this.iconBgColor,
    required this.actionColor,
    required this.actionBgColor,
    required this.actionBorderColor,
  });
}
