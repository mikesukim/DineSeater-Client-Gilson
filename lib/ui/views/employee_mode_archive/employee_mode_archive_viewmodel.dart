import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../model/waiting.dart';
import '../../../services/waiting_storage_service.dart';

class EmployeeModeArchiveViewModel extends ReactiveViewModel {
  final _navigatorService = NavigationService();
  final _waitingStorageService = locator<WaitingStorageService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_waitingStorageService];

  int getArchivedWaitingCount() {
    return _waitingStorageService.archivedWaitings.length;
  }

  Waiting getArchivedWaiting(int index) {
    return Waiting.from(_waitingStorageService.archivedWaitings[index]);
  }


  void navigateBack() {
    _navigatorService.back();
  }
}
