import 'package:flutter/material.dart';
import 'package:synk/core/app_colors.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const NavItem({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: EdgeInsets.symmetric(
          horizontal: selected ? 16 : 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.tealAccent.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: selected
              ? Border.all(
                  color: AppColors.tealAccent.withValues(alpha: 0.3),
                  width: 1.5,
                )
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? activeIcon : icon,
              size: 24,
              color: selected
                  ? AppColors.tealAccent
                  : Colors.white.withValues(alpha: 0.4),
            ),
            if (selected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.tealAccent,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
