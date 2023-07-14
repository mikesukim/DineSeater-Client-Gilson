import 'package:dineseater_client_gilson/services/cognito_service.dart';
import 'package:flutter/material.dart';
import 'package:dineseater_client_gilson/app/app.bottomsheets.dart';
import 'package:dineseater_client_gilson/app/app.dialogs.dart';
import 'package:dineseater_client_gilson/app/app.locator.dart';
import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'firebase_messaging_service.dart';

import 'package:flutter/material.dart';
import 'dart:developer';

final _cognitoService = locator<CognitoService>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // env init
  await dotenv.load(fileName: ".env");

  // Stacked init
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();

  // Firebase init
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessagingService().initialize();

  // Cognito service init
  await _cognitoService.configureAmplify();
  bool isUserSignedIn = await _cognitoService.isUserSignedIn();
  if (!isUserSignedIn) {
    await _cognitoService.signInUser(dotenv.env['COGNITO_TESTING_USER_ID']!,
        dotenv.env['COGNITO_TESTING_USER_PASSWORD']!);
  }
  String id_token = await _cognitoService.getTokenId();
  log('id_token: $id_token');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
