import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:dineseater_client_gilson/model/wait_list.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MealTypeViewModel extends BaseViewModel {
  final _navigationService = NavigationService();

  Waiting waiting;

  MealTypeViewModel({required this.waiting}) {
    if (waiting.isGrill != null) {
      selectedButton = waiting.isGrill! ? 1 : 0;
    }
  }

  int selectedButton = 0;

  void onTapMealType(int index) {
    selectedButton = index;
    notifyListeners();
  }

  void navigateBack() {
    _navigationService.back();
  }

  void navigateToPartySizeView() {
    waiting.isGrill = selectedButton == 0 ? false : true;

    _navigationService.navigateTo(Routes.partySizeView, arguments: waiting);
  }
}
