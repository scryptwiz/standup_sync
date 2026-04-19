import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synk/core/app_colors.dart';
import 'package:synk/core/widgets/app_toast.dart';
import 'package:synk/features/auth/presentation/screens/signin_screen.dart';
import 'package:synk/features/auth/state/auth_controller.dart';
import 'package:synk/features/home/presentation/widgets/home_bottom_nav.dart';
import 'package:synk/features/standup/presentation/screens/standup_history_screen.dart';
import 'package:synk/features/standup/presentation/screens/voice_to_note_screen.dart';

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
      backgroundColor: AppColors.navyDeep,
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

class _ProfilePlaceholderScreen extends ConsumerWidget {
  const _ProfilePlaceholderScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _PlaceholderPane(
      title: 'Profile',
      message:
          'Personal stats, streak badges, and account settings are coming next.',
      icon: Icons.person_rounded,
      extraContent: Column(
        children: [
          const SizedBox(height: 24),
          TextButton.icon(
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
            },
            icon: const Icon(Icons.logout_rounded, size: 20),
            label: const Text(
              'Sign out',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFFF6B6B),
              backgroundColor: const Color(0xFFFF4444).withValues(alpha: 0.12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceholderPane extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;
  final Widget? extraContent;

  const _PlaceholderPane({
    required this.title,
    required this.message,
    required this.icon,
    this.extraContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF04172C), Color(0xFF0A2540), Color(0xFF0D2D4A)],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: AppColors.glassWhite08,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.glassWhite12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: AppColors.tealAccent.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Icon(icon, size: 32, color: AppColors.tealAccent),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white.withValues(alpha: 0.5),
                      height: 1.4,
                    ),
                  ),
                  ?extraContent,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
