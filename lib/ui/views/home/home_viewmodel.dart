import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../model/waiting.dart';
import '../../../services/dineseater_api_service.dart';
import '../../../services/waiting_storage_service.dart';

class HomeViewModel extends ReactiveViewModel with WidgetsBindingObserver {
  final _navigationService = locator<NavigationService>();
  final _waitingStorageService = locator<WaitingStorageService>();
  final _dineSeaterApiService = locator<DineseaterApiService>();
  var logger = Logger();

  void initialise() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        logger.i('On Resume : reset waitings');
        final waitings = await _dineSeaterApiService.getWaitingList();
        await _waitingStorageService.resetWaitingsAs(waitings);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.hidden:
        break;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_waitingStorageService];

  void navigateToEmployeeModeView() {
    //TODO : add authentication so only employees can access this view
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
