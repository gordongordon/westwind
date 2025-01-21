import 'package:serverpod/serverpod.dart';
import 'package:westwind_server/environment_settings.dart';

import 'package:westwind_server/src/web/routes/root.dart';

import 'src/generated/protocol.dart';
import 'src/generated/endpoints.dart';

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