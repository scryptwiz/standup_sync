import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synk/core/utils/error_messages.dart';

class AppAuthState {
  final User? user;
  final Session? session;
  final bool isLoading;
  final String? error;

  const AppAuthState({
    this.user,
    this.session,
    this.isLoading = false,
    this.error,
  });

  bool get isAuthenticated => user != null && session != null;

  AppAuthState copyWith({
    User? user,
    Session? session,
    bool? isLoading,
    String? error,
  }) {
    return AppAuthState(
      user: user ?? this.user,
      session: session ?? this.session,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  static const empty = AppAuthState();
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AppAuthState>((ref) {
      return AuthController(Supabase.instance.client);
    });

class AuthController extends StateNotifier<AppAuthState> {
  final SupabaseClient _client;
  StreamSubscription<AuthState>? _authSubscription;

  AuthController(this._client) : super(AppAuthState.empty) {
    final currentSession = _client.auth.currentSession;
    state = state.copyWith(user: currentSession?.user, session: currentSession);

    _authSubscription = _client.auth.onAuthStateChange.listen(
      (data) {
        if (data.session == null) {
          state = AppAuthState.empty;
        } else {
          state = state.copyWith(
            user: data.session!.user,
            session: data.session,
            isLoading: false,
            error: null,
          );
        }
      },
      onError: (_) {
        state = AppAuthState.empty;
      },
    );
  }

  Future<void> signInWithEmail(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      state = state.copyWith(
        user: response.user,
        session: response.session,
        isLoading: false,
        error: null,
      );
    } on AuthException catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: AuthErrorMessages.fromException(e),
      );
    } on SocketException {
      state = state.copyWith(
        isLoading: false,
        error: 'Unable to connect. Please check your internet and try again.',
      );
    } on TimeoutException {
      state = state.copyWith(
        isLoading: false,
        error: 'The request timed out. Please try again.',
      );
    } catch (_) {
      state = state.copyWith(
        isLoading: false,
        error: 'Something went wrong. Please try again.',
      );
    }
  }

  Future<void> signOut() async {
    await _client.auth.signOut();
    state = AppAuthState.empty;
  }

  void clearError() {
    if (state.error == null) return;
    state = state.copyWith(error: null);
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
