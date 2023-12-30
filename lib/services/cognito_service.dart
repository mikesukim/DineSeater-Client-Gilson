import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import '../amplifyconfiguration.dart';

class CognitoService {
  // To use this service, you must first call configureAmplify()
  // currently Android is not supported
  Future<void> configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  Future<void> signInUser(String username, String password) async {
    try {
      final cognitoPlugin =
          Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      final result = await cognitoPlugin.signIn(
        username: username,
        password: password,
      );
      safePrint('login success: ${result.isSignedIn}');
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
  }

  Future<void> signOutUser() async {
    try {
      // Sign out the user from Amplify
      await Amplify.Auth.signOut();
      safePrint('logout success');
    } on AuthException catch (e) {
      safePrint('Error signing out: ${e.message}');
    }
  }

  Future<bool> isUserSignedIn() async {
    try {
      final cognitoPlugin =
          Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      final session = await cognitoPlugin.fetchAuthSession();
      return session.isSignedIn;
    } on SignedOutException catch (e) {
      safePrint('User is not signed in: ${e.message}');
      return false;
    } on AuthException catch (e) {
      safePrint('Error checking signed in: ${e.message}');
      rethrow;
    }
  }

  Future<String?> getIdToken() async {
    try {
      final cognitoPlugin =
          Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      final result = await cognitoPlugin.fetchAuthSession();
      return result.userPoolTokensResult.value.idToken.raw;
    } on SignedOutException catch (e) {
      safePrint('User is not signed in: ${e.message}');
      rethrow;
    } on AuthException catch (e) {
      safePrint('Error getting id token: ${e.message}');
      rethrow;
    }
  }
}
