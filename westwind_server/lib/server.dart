import 'dart:math';

import 'package:serverpod/serverpod.dart';
import 'package:westwind_server/environment_settings.dart';

import 'package:westwind_server/src/web/routes/root.dart';

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';
import 'package:logging/logging.dart';
import 'dart:io';

import 'package:serverpod_auth_server/serverpod_auth_server.dart' as auth;
// This is the starting point of your Serverpod server. In most cases, you will
// only need to make additions to this file if you add future calls,  are
// configuring Relic (Serverpod's web-server), or need custom setup work.

void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.

  final envSettings = EnvironmentSettings();

  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
    authenticationHandler: auth.authenticationHandler,
    config: ServerpodConfig(
      apiServer: ServerConfig(
        port: 8080,
        publicHost: 'api.examplepod.com',
        publicPort: 8080,
        publicScheme: 'https',
      ),
      webServer: ServerConfig(
        port: 8082,
        publicScheme: 'https',
        publicHost: 'web.examplepod.com',
        publicPort: 8082,
      ),
      insightsServer: ServerConfig(
        port: 8081,
        publicScheme: 'https',
        publicHost: 'insights.examplepod.com',
        publicPort: 8081,
      ),
      database: envSettings.databaseConfig,
      serviceSecret: envSettings.serviceSecret,
    ),
  );

  // If you are using any future calls, they need to be registered here.
  // pod.registerFutureCall(ExampleFutureCall(), 'exampleFutureCall');

  auth.AuthConfig.set(
    auth.AuthConfig(
      sendValidationEmail: (session, email, validationCode) async {
        // Todo : Send email to user with validation code
      //  log('code : ' , validationCode);
     //   debuggerPrint( 'code : $validationCode' );
      //  debugPrint('code : $validationCode');
             print('code : $validationCode');
             
             stdout.writeln('code : $validationCode');



               Logger.root.level = Level.ALL; // Set log level
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  


  final logger = Logger('YourAppName');
  logger.info('This will show up in Heroku logs');
  logger.warning('Warning message');
  logger.severe('Error message');
        return true;
      },
      sendPasswordResetEmail: (session, email, validationCode) async {
        // Todo : Send email to user with validation code
        print('code : $validationCode');

              stdout.writeln('code : $validationCode');
  Logger.root.level = Level.ALL; // Set log level
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
  

  final logger = Logger('YourAppName');
  logger.info('This will show up in Heroku logs');
  logger.warning('Warning message');
  logger.severe('Error message');
        return true;
      },
    ),
  );

  // Setup a default page at the web root.
  pod.webServer.addRoute(RouteRoot(), '/');
  pod.webServer.addRoute(RouteRoot(), '/index.html');
  // Serve all files in the /static directory.
  pod.webServer.addRoute(
    RouteStaticDirectory(serverDirectory: 'static', basePath: '/'),
    '/*',
  );

  // Start the server.
  await pod.start();
}