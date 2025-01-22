import 'package:dotenv/dotenv.dart';
import 'package:serverpod/serverpod.dart';

class EnvironmentSettings {
  late final DotEnv env;
  late final DatabaseConfig databaseConfig;
  late final String serviceSecret;
  late final String gmailEmail;
  late final String gmailPassword;

  EnvironmentSettings() {
    env = DotEnv(includePlatformEnvironment: true)..load();
    if (env['DATABASE_URL'] == null) {
      throw Exception("DATABASE_URUL not set in environment.");
    }

    if (env['SERVERPOD_SERVICE_SECRET'] == null) {
      throw Exception("SERVERPOD_SERVICE_SECRET not set in environment.");
    }

    if (env['GMAILEMAIL'] == null) {
      throw Exception("GMAILEMAIL not set in environment.");
    }

    if (env['GMAILPASSWORD'] == null) {
      throw Exception("GMAILPASSWORD not set in environment.");
    }

    serviceSecret = env['SERVERPOD_SERVICE_SECRET']!;

    gmailEmail = env['GMAILEMAIL']!;
    gmailPassword = env['GMAILPASSWORD']!;

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
