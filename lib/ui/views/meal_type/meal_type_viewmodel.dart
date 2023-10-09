import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MealTypeViewModel extends BaseViewModel {
  final _navigatorService = NavigationService();

  int selectedButton = 0;

  void onTapMealType(int index) {
    selectedButton = index;
    notifyListeners();
  }

  void navigateBack() {
    _navigatorService.back();
  }

  void navigateToPartySizeView() {
    _navigatorService.navigateToPartySizeView();
  }
}
