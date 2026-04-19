import 'package:flutter/material.dart';

typedef HomeNavConfig = ({IconData icon, IconData activeIcon, String label});

const homeNavItems = <HomeNavConfig>[
  (icon: Icons.mic_rounded, activeIcon: Icons.mic_rounded, label: 'Record'),
  (
    icon: Icons.history_rounded,
    activeIcon: Icons.history_rounded,
    label: 'History',
  ),
  (
    icon: Icons.leaderboard,
    activeIcon: Icons.leaderboard,
    label: 'Leaderboard',
  ),
  (icon: Icons.person, activeIcon: Icons.person, label: 'Profile'),
];
