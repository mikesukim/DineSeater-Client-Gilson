import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../model/waiting.dart';
import '../../../services/waiting_storage_service.dart';

class EmployeeModeViewModel extends ReactiveViewModel {
  final _navigatorService = NavigationService();
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

  void onTapCard(int index) {
    print('$index is tapped');
  }

  void navigateBack() {
    _navigatorService.back();
  }

  void navigateToArchiveView() {
    _navigatorService.navigateToEmployeeModeArchiveView();
  }
}
