import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class Confirm1ViewModel extends BaseViewModel {
  final _navigatorService = NavigationService();

  void navigateBack() {
    _navigatorService.back();
  }

  void navigateToMealTypeView() {
    _navigatorService.popRepeated(4);
  }

  void navigateToConfirm2View() {
    _navigatorService.navigateToConfirm2View();
  }
}
