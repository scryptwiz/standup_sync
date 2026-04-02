import 'package:flutter/material.dart';
import 'package:synk/features/home/presentation/widgets/home_nav_config.dart';
import 'package:synk/features/home/presentation/widgets/nav_item.dart';

class HomeBottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const HomeBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return _BottomNavSurface(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < homeNavItems.length; i++)
            NavItem(
              icon: homeNavItems[i].icon,
              activeIcon: homeNavItems[i].activeIcon,
              label: homeNavItems[i].label,
              selected: selectedIndex == i,
              onTap: () => onDestinationSelected(i),
            ),
        ],
      ),
    );
  }
}

class _BottomNavSurface extends StatelessWidget {
  final Widget child;

  const _BottomNavSurface({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: child,
        ),
      ),
    );
  }
}
