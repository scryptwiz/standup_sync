import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synk/core/widgets/app_toast.dart';
import 'package:synk/features/auth/presentation/screens/signin_screen.dart';
import 'package:synk/features/auth/state/auth_controller.dart';
import 'package:synk/features/home/presentation/widgets/home_bottom_nav.dart';
import 'package:synk/features/standup/presentation/screens/standup_history_screen.dart';
import 'package:synk/features/standup/presentation/screens/voice_to_note_screen.dart';
import 'package:synk/features/tasks/presentation/screens/task_tracker_screen.dart';

class HomeShellScreen extends ConsumerStatefulWidget {
  const HomeShellScreen({super.key});

  @override
  ConsumerState<HomeShellScreen> createState() => _HomeShellScreenState();
}

class _HomeShellScreenState extends ConsumerState<HomeShellScreen>
    with WidgetsBindingObserver {
  int _selectedIndex = 0;
  Timer? _connectivityTimer;
  bool _isOffline = false;

  static const List<Widget> _screens = <Widget>[
    VoiceToNoteScreen(),
    StandupHistoryScreen(),
    TaskTrackerScreen(),
    _LeaderboardPlaceholderScreen(),
    _ProfilePlaceholderScreen(),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _checkConnectivity(showBannerOnFailure: true);
    _connectivityTimer = Timer.periodic(
      const Duration(seconds: 12),
      (_) => _checkConnectivity(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkConnectivity();
    }
  }

  Future<void> _checkConnectivity({bool showBannerOnFailure = false}) async {
    bool connected = true;
    try {
      final lookup = await InternetAddress.lookup('google.com');
      connected = lookup.isNotEmpty && lookup.first.rawAddress.isNotEmpty;
    } on SocketException {
      connected = false;
    }

    if (!mounted) return;

    if (connected) {
      if (_isOffline) {
        setState(() => _isOffline = false);
        AppToast.hide();
        AppToast.success(
          context,
          message: 'Back online.',
          duration: const Duration(seconds: 2),
        );
      }
      return;
    }

    if (!_isOffline) {
      setState(() => _isOffline = true);
      _showOfflineBanner();
      return;
    }

    if (showBannerOnFailure) {
      _showOfflineBanner();
    }
  }

  void _showOfflineBanner() {
    AppToast.error(
      context,
      message: 'No internet connection. Please retry.',
      persistent: true,
      actionLabel: 'Retry',
      onAction: () => _checkConnectivity(showBannerOnFailure: true),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _connectivityTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AppAuthState>(authControllerProvider, (previous, next) {
      if (!next.isAuthenticated) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const SigninScreen()),
          (route) => false,
        );
      }
    });

    return Scaffold(
      body: _screens[_selectedIndex.clamp(0, _screens.length - 1)],
      bottomNavigationBar: HomeBottomNav(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) =>
            setState(() => _selectedIndex = index),
      ),
    );
  }
}

class _LeaderboardPlaceholderScreen extends StatelessWidget {
  const _LeaderboardPlaceholderScreen();

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderPane(
      title: 'Leaderboard',
      message: 'Team rankings and streak-based rewards will appear here.',
      icon: Icons.leaderboard_rounded,
    );
  }
}

class _ProfilePlaceholderScreen extends StatelessWidget {
  const _ProfilePlaceholderScreen();

  @override
  Widget build(BuildContext context) {
    return const _PlaceholderPane(
      title: 'Profile',
      message:
          'Personal stats, streak badges, and account settings are coming next.',
      icon: Icons.person_rounded,
    );
  }
}

class _PlaceholderPane extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const _PlaceholderPane({
    required this.title,
    required this.message,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F7FB),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFDDE2EB)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 42, color: const Color(0xFF2A5970)),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF566273),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
