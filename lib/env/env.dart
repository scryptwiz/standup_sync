import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.env.prod', name: 'ProdEnv')
@Envied(path: '.env.dev', name: 'DevEnv')
abstract class Env {
  static const String appEnv = String.fromEnvironment(
    'APP_ENV',
    defaultValue: 'dev',
  );

  factory Env() => _instance;

  static final Env _instance = appEnv == 'prod' ? _ProdEnv() : _DevEnv();

  @EnviedField(varName: 'SUPABASE_URL')
  final String supabaseUrl = _instance.supabaseUrl;

  @EnviedField(varName: 'SUPABASE_KEY', obfuscate: true)
  final String supabaseKey = _instance.supabaseKey;

  @EnviedField(varName: 'SUPABASE_ANON_KEY', obfuscate: true)
  final String supabaseAnonKey = _instance.supabaseAnonKey;
}
