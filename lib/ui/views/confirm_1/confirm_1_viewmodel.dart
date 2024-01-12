import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:dineseater_client_gilson/model/waiting_item_add_request.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../model/waiting.dart';
import '../../../model/waiting_item.dart';
import '../../../model/waiting_item_publish_request.dart';
import '../../../services/dineseater_api_service.dart';
import '../../../services/waiting_storage_service.dart';

class Confirm1ViewModel extends BaseViewModel {
  final _navigatorService = NavigationService();
  final _dineseaterApiService = locator<DineseaterApiService>();
  final _waitingStorageService = locator<WaitingStorageService>();

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

  Future<void> navigateToConfirm2View() async {
    setBusy(true);
    await addWaitingItem(waiting);
    setBusy(false);
    _navigatorService.navigateTo(Routes.confirm2View, arguments: waiting);
  }

  Future<void> addWaitingItem(Waiting waiting) async {
    final request = WaitingItemAddRequest(
        numberOfCustomers: waiting.partySize!,
        name: waiting.name!,
        detailAttribute: DetailAttribute(
          isGrill: waiting.isGrill!,
          isMeal: !(waiting.isGrill!),
        ),
        phoneNumber: waiting.mobileNumber!);

    WaitingItem addedWaiting =
        await _dineseaterApiService.addWaitingItem(request);
    await _waitingStorageService.addWaiting(addedWaiting);

    WaitingItemPublishRequest waitingItemPublishRequest = WaitingItemPublishRequest();
    waitingItemPublishRequest.waiting = addedWaiting;
    await _dineseaterApiService.publishWaitingItem(waitingItemPublishRequest);

  }
}
