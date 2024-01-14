import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class Confirm2ViewModel extends BaseViewModel {
  final _navigatorService = locator<NavigationService>();

  void navigateBack() {
    _navigatorService.back();
  }

  void navigateToHome() {
    _navigatorService.popUntil((route) => route.settings.name == '/home-view');
  }
}
