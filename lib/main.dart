import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_navigation/routes/route_delegate.dart';
import 'package:flutter_web_navigation/routes/route_information_parser.dart';
import 'package:url_strategy/url_strategy.dart';

import 'services/hive_storage_service.dart';
import 'package:hive/hive.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  if (kIsWeb) {
    setPathUrlStrategy();
    bool isUserLoggedIn = await HiveDataStorageService.getUser();
    runApp(App(
      isLoggedIn: isUserLoggedIn,
    ));
  }
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  setPathUrlStrategy();
  bool isUserLoggedIn = await HiveDataStorageService.getUser();

  runApp(App(
    isLoggedIn: isUserLoggedIn,
  ));
}

class App extends StatelessWidget {
  final bool isLoggedIn;
  const App({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Navigation',
      routeInformationParser: RoutesInformationParser(),
      routerDelegate: AppRouterDelegate(isLoggedIn: isLoggedIn),
    );
  }
}
