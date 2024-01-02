import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../model/waiting.dart';
import '../../../services/waiting_storage_service.dart';

class HomeViewModel extends ReactiveViewModel {
  final _navigationService = NavigationService();
  final _waitingStorageService = locator<WaitingStorageService>();
  var logger = Logger();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_waitingStorageService];

  int getCount() {
    logger.i('getCounter: ${_waitingStorageService.waitings}');
    return _waitingStorageService.waitings.length;
  }

  Waiting getWaiting(int index) {
    return Waiting.from(_waitingStorageService.waitings[index]);
  }

  void navigateToMealTypeView() {
    Waiting waiting = Waiting();
    _navigationService.navigateTo(Routes.mealTypeView, arguments: waiting);
  }
}
