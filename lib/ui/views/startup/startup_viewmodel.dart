import 'dart:developer';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stacked/stacked.dart';
import 'package:dineseater_client_gilson/app/app.locator.dart';
import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../firebase_messaging_service.dart';
import '../../../firebase_options.dart';
import '../../../services/cognito_service.dart';

class StartupViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  final _cognitoService = locator<CognitoService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    try {
      // env init
      await dotenv.load(fileName: ".env");

      // Firebase init
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await FirebaseMessagingService().initialize();

      // Crashlytics init
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

      // Amplify auth configuration
      await _cognitoService.configureAmplify();
    } catch (e) {
      // TODO: log error
      setError('runStartupLogic error: $e');
    }

    // login check
    final isLoggedIn = await _cognitoService.isUserSignedIn();
    safePrint('isLoggedIn: $isLoggedIn');
    if (!isLoggedIn) {
      try {
        final username = dotenv.env['COGNITO_TESTING_USER_ID']!;
        final password = dotenv.env['COGNITO_TESTING_USER_PASSWORD']!;
        await _cognitoService.signInUser(username, password);
      } catch (e) {
        // TODO: log error
        setError('signInUser error: $e');
      }
    }

    final idToken = await _cognitoService.getIdToken();
    log('idToken: $idToken');

    // Wait for 1 second
    await Future.delayed(const Duration(seconds: 1));

    // Navigate to Home
    _navigationService.replaceWithHomeView();
  }
}
