import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../model/waiting_item.dart';
import '../../../services/waiting_storage_service.dart';

class EmployeeModeArchiveViewModel extends ReactiveViewModel {
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

  int getArchivedWaitingCount() {
    return _waitingStorageService.archivedWaitings.length;
  }

  WaitingItem getArchivedWaiting(int index) {
    return _waitingStorageService.archivedWaitings[index];
  }

  void navigateBack() {
    _navigatorService.back();
  }
}
