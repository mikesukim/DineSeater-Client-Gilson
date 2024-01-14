import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../model/waiting.dart';
import '../../../model/waiting_item.dart';
import '../../../services/waiting_storage_service.dart';

// TODO: timers should not be reset when coming back from other view.
// TODO: when a card is archived by tapping cancel or confirm button, the next card state is also changed to table is ready, which shouldn't be changed.
class EmployeeModeViewModel extends ReactiveViewModel {
  final _navigatorService = locator<NavigationService>();
  final _waitingStorageService = locator<WaitingStorageService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_waitingStorageService];

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
