import 'dart:async';

import 'package:dineseater_client_gilson/app/app.dialogs.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../../app/app.locator.dart';
import '../../../model/action_type.dart';
import '../../../model/waiting_item.dart';
import '../../../model/waiting_item_update_request.dart';
import '../../../model/waiting_status.dart';
import '../../../services/dineseater_api_service.dart';
import '../../../services/waiting_storage_service.dart';

class WaitingCardViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _waitingStorageService = locator<WaitingStorageService>();
  final _dineSeaterApiService = locator<DineseaterApiService>();

  bool isTableReady = false;
  bool isTimerEnd = false;

  WaitingItem waiting;
  late StopWatchTimer stopWatchTimer;

  WaitingCardViewModel(this.waiting) {
    stopWatchTimer =
        StopWatchTimer(mode: StopWatchMode.countDown, onEnded: onTimerEnd);
    stopWatchTimer.setPresetSecondTime(20);

    if (waiting.status == WaitingStatus.TEXT_SENT.name) {
      isTableReady = true;
      // TODO : remaining time is not synced yet
      stopWatchTimer.onStartTimer();
    }
  }

  void showWaitingInfoDialog(WaitingItem waiting) async {
    DialogResponse? response = await _dialogService.showCustomDialog(
        variant: DialogType.waitingInfo,
        barrierDismissible: true,
        data: waiting);

    if (response != null && response.confirmed) {
      notifyListeners();
    }
  }

  Future<void> onTapTableReady(WaitingItem waitingItem) async {
    isTableReady = true;

    stopWatchTimer.onStartTimer();

    waitingItem.status = WaitingStatus.TEXT_SENT.name;
    WaitingItemUpdateRequest waitingItemUpdateRequest =
        WaitingItemUpdateRequest();
    waitingItemUpdateRequest.waitingId = waitingItem.waitingId;
    waitingItemUpdateRequest.action = ActionType.NOTIFY;

    setBusy(true);
    await _dineSeaterApiService.updateWaitingItem(waitingItemUpdateRequest);
    await _waitingStorageService.updateWaiting(waitingItem);
    setBusy(false);

    notifyListeners();
  }

  // TODO: display confirm alert dialog
  Future<void> onTapCancel(WaitingItem waitingItem) async {

    waitingItem.status = WaitingStatus.MISSED.name;
    WaitingItemUpdateRequest waitingItemUpdateRequest =
        WaitingItemUpdateRequest();
    waitingItemUpdateRequest.waitingId = waitingItem.waitingId;
    waitingItemUpdateRequest.action = ActionType.REPORT_MISSED;

    setBusy(true);
    await _dineSeaterApiService.updateWaitingItem(waitingItemUpdateRequest);
    await _waitingStorageService.updateWaiting(waitingItem);
    setBusy(false);

    stopWatchTimer.onStopTimer();

    notifyListeners();
  }

  // TODO: display confirm alert dialog
  Future<void> onTapConfirm(WaitingItem waitingItem) async {

    waitingItem.status = WaitingStatus.ARRIVED.name;
    WaitingItemUpdateRequest waitingItemUpdateRequest =
        WaitingItemUpdateRequest();
    waitingItemUpdateRequest.waitingId = waitingItem.waitingId;
    waitingItemUpdateRequest.action = ActionType.REPORT_ARRIVAL;

    setBusy(true);
    await _dineSeaterApiService.updateWaitingItem(waitingItemUpdateRequest);
    await _waitingStorageService.updateWaiting(waitingItem);
    setBusy(false);

    stopWatchTimer.onStopTimer();

    notifyListeners();
  }

  void onTimerEnd() {
    isTimerEnd = true;

    notifyListeners();
  }

  Future<void> onTapBackToList(WaitingItem waitingItem) async {

    waitingItem.status = WaitingStatus.WAITING.name;
    WaitingItemUpdateRequest waitingItemUpdateRequest =
        WaitingItemUpdateRequest();
    waitingItemUpdateRequest.waitingId = waitingItem.waitingId;
    waitingItemUpdateRequest.action = ActionType.REPORT_BACK_INITIAL_STATUS;

    setBusy(true);
    await _dineSeaterApiService.updateWaitingItem(waitingItemUpdateRequest);
    await _waitingStorageService.updateWaiting(waitingItem);
    setBusy(false);

    stopWatchTimer.onStopTimer();
  }
}
