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

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';

import 'amplifyconfiguration.dart';

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

  // Cognito init (raieses error on Android)
  await _configureAmplify();

  // User signin flow
  bool isUserSignedIn = await _isUserSignedIn();
  if (!isUserSignedIn) {
    await _signInUser(dotenv.env['COGNITO_TESTING_USER_ID']!,
        dotenv.env['COGNITO_TESTING_USER_PASSWORD']!);
  }
  String id_token = await _getTokenId();
  safePrint('id_token: $id_token');

  runApp(const MainApp());
}

Future<void> _configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    await Amplify.addPlugin(auth);

    // call Amplify.configure to use the initialized categories in your app
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('An error occurred configuring Amplify: $e');
  }
}

Future<void> _signInUser(String username, String password) async {
  try {
    final result = await Amplify.Auth.signIn(
      username: username,
      password: password,
    );
    safePrint('login success: ${result.isSignedIn}');

    // await _handleSignInResult(result);
  } on AuthException catch (e) {
    safePrint('Error signing in: ${e.message}');
  }
}

Future<void> _signOutUser() async {
  try {
    // Sign out the user from Amplify
    await Amplify.Auth.signOut();
    safePrint('logout success');
  } on AuthException catch (e) {
    safePrint('Error signing out: ${e.message}');
  }
}

Future<bool> _isUserSignedIn() async {
  try {
    final session = await Amplify.Auth.fetchAuthSession();
    return session.isSignedIn;
  } on SignedOutException catch (e) {
    safePrint('User is not signed in: ${e.message}');
    return false;
  } on AuthException catch (e) {
    safePrint('Error checking signed in: ${e.message}');
    rethrow;
  }
}

Future<String> _getTokenId() async {
  try {
    final authSession = (await Amplify.Auth.fetchAuthSession(
      options: CognitoSessionOptions(getAWSCredentials: true),
    )) as CognitoAuthSession;
    return authSession.userPoolTokens!.idToken;
  } on AmplifyException catch (e) {
    safePrint('error occurred while retrieving Token ID : ${e.message}');
    rethrow;
  }
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
