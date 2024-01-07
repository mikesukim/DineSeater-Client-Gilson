import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

// TODO : block sliding back to previous page
class Confirm2ViewModel extends BaseViewModel {
  final _navigatorService = NavigationService();

  void navigateBack() {
    _navigatorService.back();
  }

  void navigateToHome() {
    _navigatorService.popRepeated(6);
  }
}
