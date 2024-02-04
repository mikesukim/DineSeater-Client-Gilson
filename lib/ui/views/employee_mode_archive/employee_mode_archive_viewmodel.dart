import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../model/waiting_item.dart';
import '../../../services/waiting_storage_service.dart';
import '../../../services/dineseater_api_service.dart';

class EmployeeModeArchiveViewModel extends ReactiveViewModel {
  final _navigatorService = locator<NavigationService>();
  final _waitingStorageService = locator<WaitingStorageService>();
  final _dineseater_api_service = locator<DineseaterApiService>();

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

  Future<void> onRefresh() async {
    try {
      List<WaitingItem> waitings =
      await _dineseater_api_service.getWaitingListAfter(DateTime.now());
      await _waitingStorageService.resetWaitingsAs(waitings);
    } catch (e) {
      setError(e);
      rethrow;
    }
  }
}
