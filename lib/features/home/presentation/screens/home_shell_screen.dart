import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:synk/features/auth/presentation/screens/signin_screen.dart';
import 'package:synk/features/auth/state/auth_controller.dart';
import 'package:synk/features/feedback/presentation/screens/feedback_screen.dart';
import 'package:synk/features/home/presentation/widgets/home_bottom_nav.dart';
import 'package:synk/features/standup/presentation/screens/voice_to_note_screen.dart';
import 'package:synk/features/tasks/presentation/screens/task_tracker_screen.dart';

class HomeShellScreen extends ConsumerStatefulWidget {
  const HomeShellScreen({super.key});

  @override
  ConsumerState<HomeShellScreen> createState() => _HomeShellScreenState();
}

class _HomeShellScreenState extends ConsumerState<HomeShellScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = <Widget>[
    VoiceToNoteScreen(),
    TaskTrackerScreen(),
    FeedbackScreen(),
  ];

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
