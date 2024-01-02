import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:localstorage/localstorage.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dineseater_client_gilson/app/app.locator.dart';
import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/cognito_service.dart';
import '../../../services/dineseater_api_service.dart';
import '../../../services/waiting_storage_service.dart';

class StartupViewModel extends BaseViewModel {
  var logger = Logger();
  final _navigationService = locator<NavigationService>();
  final _cognitoService = locator<CognitoService>();
  final _dineSeaterApiService = locator<DineseaterApiService>();
  final _waitingStorageService = locator<WaitingStorageService>();

  // Place anything here that needs to happen before we get into the application
  Future runStartupLogic() async {
    try {
      // Amplify auth configuration
      await _cognitoService.configureAmplify();

      logger.i('runStartupLogic completed');
    } catch (e) {
      final errorMessage = 'runStartupLogic error: $e';
      logger.e(errorMessage);
      setError(errorMessage);
    }

    // login check
    final isLoggedIn = await _cognitoService.isUserSignedIn();
    logger.i('isLoggedIn: $isLoggedIn');
    if (!isLoggedIn) {
      try {
        final username = dotenv.env['COGNITO_TESTING_USER_ID']!;
        final password = dotenv.env['COGNITO_TESTING_USER_PASSWORD']!;
        await _cognitoService.signInUser(username, password);
      } catch (e) {
        final errorMessage = 'signInUser error: $e';
        logger.e(errorMessage);
        setError(errorMessage);
      }
    }

    final idToken = await _cognitoService.getIdToken();
    log('idToken: $idToken');

    // device registration for notification
    // registration is done only once after app installation
    String? deviceToken = await FirebaseMessaging.instance.getToken();
    log('Device token: $deviceToken');
    final LocalStorage appInitFlagsStorage = LocalStorage('app_init_flags');
    await appInitFlagsStorage.ready;
    if (appInitFlagsStorage.getItem('isDeviceTokenRegistered') == null ||
        appInitFlagsStorage.getItem('isDeviceTokenRegistered') == false) {
      logger.i("Device token is not registered yet. Registering...");
      _dineSeaterApiService.registerDeviceToken(deviceToken!);
      appInitFlagsStorage.setItem('isDeviceTokenRegistered', true);
      logger.i("Device token is registered.");
    }

    // WaitingStorageService init
    await _waitingStorageService.init();

    // Navigate to Home
    _navigationService.replaceWithHomeView();
  }
}
