import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class Confirm2ViewModel extends BaseViewModel {
  final _navigatorService = NavigationService();

  void navigateToHome() {
    _navigatorService.popRepeated(6);
  }
}
