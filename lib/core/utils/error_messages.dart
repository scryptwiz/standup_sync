import 'package:supabase_flutter/supabase_flutter.dart';

/// Maps Supabase [AuthException] errors to user-friendly messages.
class AuthErrorMessages {
  static String fromException(AuthException e) {
    switch (e.code) {
      case 'over_email_send_rate_limit':
        return 'Too many attempts. Please wait a few minutes and try again.';
      case 'email_not_confirmed':
        return 'Your email hasn\'t been verified yet. Check your inbox for a confirmation link.';
      case 'invalid_credentials':
        return 'Incorrect email or password. Please try again.';
      case 'user_not_found':
        return 'No account found with this email. Please sign up first.';
      case 'user_already_exists':
        return 'An account with this email already exists. Please sign in.';
      case 'weak_password':
        return 'Your password is too weak. Use at least 6 characters.';
      case 'same_password':
        return 'New password must be different from your current password.';
      case 'otp_expired':
        return 'Your verification link has expired. Please request a new one.';
      case 'session_not_found':
        return 'Your session has expired. Please sign in again.';
      default:
        return _fromMessage(e.message);
    }
  }

  static String _fromMessage(String message) {
    final lower = message.toLowerCase();

    if (lower.contains('rate limit') || lower.contains('too many requests')) {
      return 'Too many attempts. Please wait a few minutes and try again.';
    }
    if (lower.contains('invalid login credentials') ||
        lower.contains('invalid_credentials')) {
      return 'Incorrect email or password. Please try again.';
    }
    if (lower.contains('email not confirmed')) {
      return 'Your email hasn\'t been verified yet. Check your inbox for a confirmation link.';
    }
    if (lower.contains('user already registered') ||
        lower.contains('already exists')) {
      return 'An account with this email already exists. Please sign in.';
    }
    if (lower.contains('network') ||
        lower.contains('socket') ||
        lower.contains('connection')) {
      return 'Unable to connect. Please check your internet and try again.';
    }

    return 'Something went wrong. Please try again.';
  }
}

/// Generic network / API error messages.
class NetworkErrorMessages {
  static String fromException(Exception e) {
    final msg = e.toString().toLowerCase();

    if (msg.contains('timeout')) {
      return 'Request timed out. Please try again.';
    }
    if (msg.contains('socket') ||
        msg.contains('connection') ||
        msg.contains('network')) {
      return 'Unable to connect. Please check your internet and try again.';
    }

    return 'Something went wrong. Please try again.';
  }
}
