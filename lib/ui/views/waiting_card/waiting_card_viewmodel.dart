import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../model/action_type.dart';
import '../../../model/waiting_item.dart';
import '../../../model/waiting_item_update_request.dart';
import '../../../model/waiting_status.dart';
import '../../../services/dineseater_api_service.dart';
import '../../../services/waiting_storage_service.dart';

class WaitingCardViewModel extends BaseViewModel {
  final _waitingStorageService = locator<WaitingStorageService>();
  final _dineseaterApiService = locator<DineseaterApiService>();

  bool isTableReady = false;
  bool isTimerEnd = false;

  Future<void> onTapTableReady(int index) async {
    isTableReady = true;
    //TODO: error handling
    WaitingItem waitingItem = _waitingStorageService.waitings[index];
    waitingItem.status = WaitingStatus.TEXT_SENT.name;
    WaitingItemUpdateRequest waitingItemUpdateRequest = WaitingItemUpdateRequest();
    waitingItemUpdateRequest.waitingId = waitingItem.waitingId;
    waitingItemUpdateRequest.action = ActionType.NOTIFY;

    setBusy(true);
    await _dineseaterApiService.updateWaitingItem(waitingItemUpdateRequest);
    await _waitingStorageService.updateWaiting(waitingItem);
    setBusy(false);

    notifyListeners();
  }

  void onTimerEnd(int index) {
    isTimerEnd = true;

    notifyListeners();
  }

  Future<void> onTapCancel(int index) async {
    isTableReady = false;

    //TODO: error handling
    WaitingItem waitingItem = _waitingStorageService.waitings[index];
    waitingItem.status = WaitingStatus.MISSED.name;
    WaitingItemUpdateRequest waitingItemUpdateRequest = WaitingItemUpdateRequest();
    waitingItemUpdateRequest.waitingId = waitingItem.waitingId;
    waitingItemUpdateRequest.action = ActionType.REPORT_MISSED;

    setBusy(true);
    await _dineseaterApiService.updateWaitingItem(waitingItemUpdateRequest);
    await _waitingStorageService.updateWaiting(waitingItem);
    setBusy(false);

    notifyListeners();
  }

  Future<void> onTapConfirm(int index) async {
    isTableReady = false;

    //TODO: error handling
    WaitingItem waitingItem = _waitingStorageService.waitings[index];
    waitingItem.status = WaitingStatus.ARRIVED.name;
    WaitingItemUpdateRequest waitingItemUpdateRequest = WaitingItemUpdateRequest();
    waitingItemUpdateRequest.waitingId = waitingItem.waitingId;
    waitingItemUpdateRequest.action = ActionType.REPORT_ARRIVAL;

    setBusy(true);
    await _dineseaterApiService.updateWaitingItem(waitingItemUpdateRequest);
    await _waitingStorageService.updateWaiting(waitingItem);
    setBusy(false);

    notifyListeners();
  }

  void onTapBackToList() {
    print('back to list');
  }

  void onTapEditCard() {
    print('edit card');
  }
}
