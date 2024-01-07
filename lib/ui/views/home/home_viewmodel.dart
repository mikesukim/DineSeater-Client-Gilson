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

  List<Waiting> waitingList = [
    Waiting(name: 'Ilsan Noh', partySize: 2, isGrill: false),
    Waiting(name: 'Seattle Kim', partySize: 3, isGrill: true),
    Waiting(name: 'Kay K', partySize: 1, isGrill: false),
    Waiting(name: 'Seeun P', partySize: 6, isGrill: false),
    Waiting(name: 'Yulmoo Mom', partySize: 3, isGrill: true),
    Waiting(name: 'Aron Cho', partySize: 2, isGrill: true),
    Waiting(name: 'Ilsan Noh', partySize: 2, isGrill: false),
    Waiting(name: 'Seattle Kim', partySize: 3, isGrill: true),
    Waiting(name: 'Kay K', partySize: 1, isGrill: false),
    Waiting(name: 'Seeun P', partySize: 6, isGrill: false),
    Waiting(name: 'Yulmoo Mom', partySize: 3, isGrill: true),
    Waiting(name: 'Aron Cho', partySize: 2, isGrill: true)
  ];

  void navigateToEmployeeModeView() {
    _navigationService.navigateToEmployeeModeView();
  }

  int getWaitingCount() {
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
