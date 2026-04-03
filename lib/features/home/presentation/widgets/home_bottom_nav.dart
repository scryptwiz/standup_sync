import 'package:flutter/material.dart';
import 'package:synk/core/app_colors.dart';
import 'package:synk/features/home/presentation/widgets/home_nav_config.dart';
import 'package:synk/features/home/presentation/widgets/home_nav_item.dart';

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
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.navyDeep,
        border: Border(top: BorderSide(color: Color(0xFF1A2C42), width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
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
        ),
      ),
    );
  }
}
