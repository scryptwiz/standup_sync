import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synk/app/app.dart';
import 'package:synk/core/utils/secure_session_storage.dart';
import 'package:synk/env/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: Env().supabaseUrl,
    anonKey: Env().supabaseKey,
    authOptions: FlutterAuthClientOptions(
      autoRefreshToken: true,
      localStorage: SecureSessionStorage(),
    ),
  );
  runApp(const ProviderScope(child: SynkApp()));
}
