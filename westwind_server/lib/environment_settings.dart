import 'package:dotenv/dotenv.dart';
import 'package:serverpod/serverpod.dart';

class EnvironmentSettings {
  late final DotEnv env;
  late final DatabaseConfig databaseConfig;
  late final String serviceSecret;

  EnvironmentSettings() {
    env = DotEnv(includePlatformEnvironment: true)..load();
    if (env['HEROKU_POSTGRESQL_AMBER_URL'] == null) {
      throw Exception("HEROKU_POSTGRESQL_AMBER_URL not set in environment.");
    }

    if (env['SERVERPOD_SERVICE_SECRET'] == null) {
      throw Exception("SERVERPOD_SERVICE_SECRET not set in environment.");
    }

    serviceSecret = env['SERVERPOD_SERVICE_SECRET']!;

    final dbUri = Uri.parse(env['DATABASE_URL']!);
    final dbNoSsl = env['DATABASE_NO_SSL'] == 'true';

    databaseConfig = DatabaseConfig(
      host: dbUri.host,
      port: dbUri.port,
      user: dbUri.userInfo.split(":").first,
      password: dbUri.userInfo.split(":").last,
      name: dbUri.pathSegments.first,
      requireSsl: !dbNoSsl,
    );
  }
}
