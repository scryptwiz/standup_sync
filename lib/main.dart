import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:synk/app/app.dart';
import 'package:synk/env/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: Env().supabaseUrl, anonKey: Env().supabaseKey);
  runApp(const SynkApp());
}
