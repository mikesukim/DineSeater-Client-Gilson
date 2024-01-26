import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:dineseater_client_gilson/model/waiting_status.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../model/waiting_item.dart';
import '../../../services/waiting_storage_service.dart';

class EmployeeModeViewModel extends ReactiveViewModel {
  final _navigatorService = locator<NavigationService>();
  final _waitingStorageService = locator<WaitingStorageService>();

  bool isLoading = false;

  List<bool> isSelected = [true, false];
  List<Widget> toggleSelections = [
    const Text(
      'All',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    const Text(
      'Notified',
      style: TextStyle(fontWeight: FontWeight.bold),
    )
  ];

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_waitingStorageService];

  void toggleIsLoading() {
    isLoading = !isLoading;

    notifyListeners();
  }

  // TODO: change this logic using enum for scalability. If toggle buttons expand.
  int get getWaitingCount => isSelected[0]
      ? _waitingStorageService.waitings.length
      : notifiedList.length;

  List<WaitingItem> get notifiedList => _waitingStorageService.waitings
      .where((WaitingItem waitingItem) =>
          waitingItem.status == WaitingStatus.TEXT_SENT.name.toLowerCase())
      .toList();

  WaitingItem getWaitingItem(int index) {
    if (isSelected[0]) {
      return _waitingStorageService.waitings[index];
    } else {
      return notifiedList[index];
    }
  }

  void onTapToggleButton(int index) {
    for (int i = 0; i < isSelected.length; i++) {
      isSelected[i] = index == i;
    }

    notifyListeners();
  }

  void navigateBack() {
    _navigatorService.back();
  }

  void navigateToArchiveView() {
    _navigatorService.navigateToEmployeeModeArchiveView();
  }
}
