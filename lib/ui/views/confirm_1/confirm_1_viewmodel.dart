import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:dineseater_client_gilson/model/waiting_item_add_request.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/app.locator.dart';
import '../../../model/waiting.dart';
import '../../../model/waiting_item.dart';
import '../../../model/waiting_item_publish_request.dart';
import '../../../services/dineseater_api_service.dart';
import '../../../services/waiting_storage_service.dart';

class Confirm1ViewModel extends BaseViewModel {
  final _navigatorService = locator<NavigationService>();
  final _dineSeaterApiService = locator<DineseaterApiService>();
  final _waitingStorageService = locator<WaitingStorageService>();

  Waiting waiting;
  late String formattedMobileNumber;

  final Uri termsOfService = Uri.parse('https://dineseater-public.s3.us-west-2.amazonaws.com/Terms+of+Service.pdf');
  final Uri privacyPolicy = Uri.parse('https://dineseater-public.s3.us-west-2.amazonaws.com/Privacy+Policy.pdf');

  Confirm1ViewModel({required this.waiting}) {
    formattedMobileNumber = waiting.mobileNumber!;
    formattedMobileNumber =
        '${formattedMobileNumber.substring(0, 2)} (${formattedMobileNumber.substring(2, 5)}) ${formattedMobileNumber.substring(5, 8)} ${formattedMobileNumber.substring(8, 12)}';
  }

  Future<void> launchUrlLink(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void navigateBack() {
    _navigatorService.back();
  }

  void navigateToMealTypeView() {
    _navigatorService
        .popUntil((route) => route.settings.name == '/meal-type-view');
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

    try {
      WaitingItem addedWaiting =
      await _dineSeaterApiService.addWaitingItem(request);
      await _waitingStorageService.addWaiting(addedWaiting);

      WaitingItemPublishRequest waitingItemPublishRequest =
      WaitingItemPublishRequest();
      waitingItemPublishRequest.waiting = addedWaiting;
      await _dineSeaterApiService.publishWaitingItem(waitingItemPublishRequest);

      await FirebaseAnalytics.instance.logEvent(
        name: "select_confirm_to_join_waiting_list",
        parameters: {
          "waitingItem": addedWaiting.toJson().toString(),
        },
      );
    } catch (e) {
      final errorMessage = 'addWaitingItem error: $e';
      setError(errorMessage);
      rethrow;
    }
  }
}
