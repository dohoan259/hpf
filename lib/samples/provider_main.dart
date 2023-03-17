import 'package:hpf_cli/samples/sample.dart';

class ProviderMainSample extends Sample {
  final bool? isServer;
  ProviderMainSample({this.isServer}) : super('lib/main.dart', overwrite: true);

  String get _flutterMain =>
      '''import 'package:breaking_new/presentation/routers/routers.gr.dart';
import 'package:flutter/material.dart';

import 'di/di.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
  ''';

  String get _serverMain => '''import 'package:get_server/get_server.dart';
import 'app/routes/app_pages.dart';

void main() {
  runApp(GetServer(
    getPages: AppPages.routes,
  ));
}
  ''';

  @override
  String get content => isServer! ? _serverMain : _flutterMain;
}
