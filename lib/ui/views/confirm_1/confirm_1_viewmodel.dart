import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/waiting.dart';

class Confirm1ViewModel extends BaseViewModel {
  final _navigatorService = NavigationService();

  Waiting waiting;
  late String formattedMobileNumber;

  Confirm1ViewModel({required this.waiting}) {
    formattedMobileNumber = waiting.mobileNumber!;
    formattedMobileNumber =
        '${formattedMobileNumber.substring(0, 2)} (${formattedMobileNumber.substring(2, 5)}) ${formattedMobileNumber.substring(5, 8)} ${formattedMobileNumber.substring(8, 12)}';
  }

  void navigateBack() {
    _navigatorService.back();
  }

  void navigateToMealTypeView() {
    _navigatorService.navigateTo(Routes.mealTypeView, arguments: waiting);
  }

  void navigateToConfirm2View() {
    _navigatorService.navigateTo(Routes.confirm2View, arguments: waiting);
  }
}
