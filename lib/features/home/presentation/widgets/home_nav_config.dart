import 'package:flutter/material.dart';

typedef HomeNavConfig = ({IconData icon, IconData activeIcon, String label});

const homeNavItems = <HomeNavConfig>[
  (icon: Icons.mic_rounded, activeIcon: Icons.mic_rounded, label: 'Record'),
  (icon: Icons.task_rounded, activeIcon: Icons.task_rounded, label: 'Tasks'),
  (
    icon: Icons.leaderboard,
    activeIcon: Icons.leaderboard,
    label: 'Leaderboard',
  ),
  (
    icon: Icons.rate_review_rounded,
    activeIcon: Icons.rate_review_rounded,
    label: 'Feedback',
  ),
  (icon: Icons.person, activeIcon: Icons.person, label: 'Profile'),
];
