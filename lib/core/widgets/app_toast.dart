import 'dart:async';

import 'package:flutter/material.dart';

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
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: style.background,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: style.borderColor, width: 1.2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1F000000),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(style.icon, color: style.iconColor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      message,
                      style: TextStyle(
                        color: style.textColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (actionLabel != null && onAction != null) ...[
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: onAction,
                      style: TextButton.styleFrom(
                        foregroundColor: style.actionColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        minimumSize: const Size(0, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(actionLabel),
                    ),
                  ],
                ],
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
        return const _AppToastStyle(
          icon: Icons.check_circle_rounded,
          background: Color(0xFFE8F8EE),
          borderColor: Color(0xFF86D7A5),
          textColor: Color(0xFF14532D),
          iconColor: Color(0xFF15803D),
          actionColor: Color(0xFF166534),
        );
      case AppToastType.error:
        return const _AppToastStyle(
          icon: Icons.error_rounded,
          background: Color(0xFFFFEFEF),
          borderColor: Color(0xFFF6A7A7),
          textColor: Color(0xFF7F1D1D),
          iconColor: Color(0xFFB91C1C),
          actionColor: Color(0xFF9F1239),
        );
    }
  }
}

class _AppToastStyle {
  final IconData icon;
  final Color background;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;
  final Color actionColor;

  const _AppToastStyle({
    required this.icon,
    required this.background,
    required this.borderColor,
    required this.textColor,
    required this.iconColor,
    required this.actionColor,
  });
}
