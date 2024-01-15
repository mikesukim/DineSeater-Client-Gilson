import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../model/waiting.dart';
import '../../../model/waiting_item.dart';
import '../../../services/waiting_storage_service.dart';

// TODO: time is not synced yet. If status is text_sent, current time - text sent time.
class EmployeeModeViewModel extends ReactiveViewModel {
  final _navigatorService = locator<NavigationService>();
  final _waitingStorageService = locator<WaitingStorageService>();

  bool isLoading = false;

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_waitingStorageService];

  void toggleIsLoading() {
    isLoading = !isLoading;

    notifyListeners();
  }

  int getWaitingCount() {
    return _waitingStorageService.waitings.length;
  }

  Waiting getWaiting(int index) {
    return Waiting.from(_waitingStorageService.waitings[index]);
  }

  WaitingItem getWaitingItem(int index) {
    return _waitingStorageService.waitings[index];
  }

  void navigateBack() {
    _navigatorService.back();
  }

  void navigateToArchiveView() {
    _navigatorService.navigateToEmployeeModeArchiveView();
  }
}
