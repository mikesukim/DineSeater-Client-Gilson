import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MealTypeViewModel extends BaseViewModel {
  final _navigatorService = NavigationService();

  // List<bool> isSelected = [false, false];
  int selectedButton = -1;

  void onTapMealType(int index) {
    selectedButton = index;
    notifyListeners();
  }

  void navigateBack() {
    _navigatorService.back();
  }
}
