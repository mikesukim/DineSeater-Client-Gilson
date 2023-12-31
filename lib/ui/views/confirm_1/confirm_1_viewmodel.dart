import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:dineseater_client_gilson/model/waiting_item_add_request.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../model/waiting.dart';
import '../../../model/waiting_item.dart';
import '../../../services/dineseater_api_service.dart';

class Confirm1ViewModel extends BaseViewModel {
  final _navigatorService = NavigationService();
  final _dineseaterApiService = locator<DineseaterApiService>();

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
    addWaitingItem(waiting);
    _navigatorService.navigateTo(Routes.confirm2View, arguments: waiting);
  }

  void addWaitingItem(Waiting waiting) {
    final request = WaitingItemAddRequest(
        numberOfCustomers: waiting.partySize!,
        detailAttribute: DetailAttribute(
          isGrill: waiting.isGrill!,
          isMeal: !(waiting.isGrill!),
        ),
        phoneNumber: waiting.mobileNumber!);

    _dineseaterApiService.addWaitingItem(request);
  }
}
