import 'dart:async';

import 'package:dineseater_client_gilson/app/app.dialogs.dart';
import 'package:dineseater_client_gilson/model/waiting_item_publish_request.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
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

// parent view's loading is required, due to SNS message sending threshold.
class WaitingCardViewModel extends BaseViewModel {
  final _dialogService = locator<DialogService>();
  final _waitingStorageService = locator<WaitingStorageService>();
  final _dineSeaterApiService = locator<DineseaterApiService>();

  bool isTextSent = false;
  bool isTimerEnd = false;

  WaitingItem waitingItem;
  late StopWatchTimer stopWatchTimer;
  final Function toggleIsLoadingFromParent;
  final Function setErrorFromParent;

  final _waitingTime = int.parse(dotenv.env['WAITING_TIME_IN_SEC']!);

  String get dateCreated =>
      DateFormat('HH:mm a').format(DateTime.parse(waitingItem.dateCreated));

  String get lastModified =>
      DateFormat('HH:mm a').format(DateTime.parse(waitingItem.lastModified));

  String get formattedPhoneNumber =>
      '${waitingItem.phoneNumber.substring(2, 5)}-${waitingItem.phoneNumber.substring(5, 8)}-${waitingItem.phoneNumber.substring(8, 12)}';

  WaitingCardViewModel(this.waitingItem, this.toggleIsLoadingFromParent, this.setErrorFromParent) {
    stopWatchTimer =
        StopWatchTimer(mode: StopWatchMode.countDown, onEnded: onTimerEnd);

    stopWatchTimer.setPresetSecondTime(_waitingTime);

    if (waitingItem.status.toUpperCase() == WaitingStatus.TEXT_SENT.name) {
      isTextSent = true;

      DateTime now = DateTime.now();
      DateTime lastModified = DateTime.parse(waitingItem.lastModified);
      int remainingTime = _waitingTime - now.difference(lastModified).inSeconds;

      if (remainingTime <= 0) {
        isTimerEnd = true;
        stopWatchTimer.clearPresetTime();
        stopWatchTimer.onStopTimer();
      } else {
        stopWatchTimer.clearPresetTime();
        stopWatchTimer.setPresetSecondTime(remainingTime);
        stopWatchTimer.onStartTimer();
      }
    } else {
      isTextSent = false;
      stopWatchTimer.onStopTimer();
    }
  }

  void onTimerEnd() {
    isTimerEnd = true;

    notifyListeners();
  }

  Future<void> showConfirmDialog(WaitingItem waitingItem,
      {bool isArchiveView = false, bool isCancel = false}) async {
    DialogResponse? response = await _dialogService.showCustomDialog(
        variant: DialogType.confirmAlert,
        title: isArchiveView
            ? 'Are you sure you want to return ${waitingItem.name} to the list?'
            : isCancel
                ? 'Are you sure you want to remove ${waitingItem.name} from the list?'
                : 'Send text to ${waitingItem.name}',
        barrierDismissible: true);

    if (response != null && response.confirmed) {
      isArchiveView
          ? onTapBackToList(waitingItem)
          : isCancel
              ? onTapCancel(waitingItem)
              : onTapTableReady(waitingItem);
    }
  }

  Future<void> onTapTableReady(WaitingItem waitingItem) async {
    isTextSent = true;

    toggleIsLoadingFromParent();

    stopWatchTimer.onStartTimer();

    WaitingItemUpdateRequest waitingItemUpdateRequest =
        WaitingItemUpdateRequest();
    waitingItemUpdateRequest.waitingId = waitingItem.waitingId;
    waitingItemUpdateRequest.action = ActionType.NOTIFY;

    try {
      await FirebaseAnalytics.instance.logEvent(
        name: "select_table_ready",
        parameters: {
          "waitingItem": waitingItem.toJson().toString(),
        },
      );

      WaitingItem updatedItem =
      await _dineSeaterApiService.updateWaitingItem(waitingItemUpdateRequest);

      waitingItem.status = WaitingStatus.TEXT_SENT.name;
      await _waitingStorageService.updateWaiting(updatedItem);

      WaitingItemPublishRequest waitingItemPublishRequest =
      WaitingItemPublishRequest();
      waitingItemPublishRequest.waiting = updatedItem;
      await _dineSeaterApiService.publishWaitingItem(waitingItemPublishRequest);

    } catch (e) {
      final errorMessage = 'onTapTableReady error: $e';
      setErrorFromParent(errorMessage);
      rethrow;
    }

    toggleIsLoadingFromParent();

    notifyListeners();
  }

  Future<void> onTapMiss(WaitingItem waitingItem) async {
    stopWatchTimer.onStopTimer();

    toggleIsLoadingFromParent();

    WaitingItemUpdateRequest waitingItemUpdateRequest =
        WaitingItemUpdateRequest();
    waitingItemUpdateRequest.waitingId = waitingItem.waitingId;
    waitingItemUpdateRequest.action = ActionType.REPORT_MISSED;

    try {
      await FirebaseAnalytics.instance.logEvent(
        name: "select_miss",
        parameters: {
          "waitingItem": waitingItem.toJson().toString(),
        },
      );

      WaitingItem updatedItem =
      await _dineSeaterApiService.updateWaitingItem(waitingItemUpdateRequest);

      waitingItem.status = WaitingStatus.MISSED.name;
      await _waitingStorageService.updateWaiting(updatedItem);

      WaitingItemPublishRequest waitingItemPublishRequest =
      WaitingItemPublishRequest();
      waitingItemPublishRequest.waiting = updatedItem;
      await _dineSeaterApiService.publishWaitingItem(waitingItemPublishRequest);

    } catch (e) {
      final errorMessage = 'onTapMiss error: $e';
      setErrorFromParent(errorMessage);
      rethrow;
    }

    toggleIsLoadingFromParent();

    notifyListeners();
  }

  Future<void> onTapArrived(WaitingItem waitingItem) async {
    toggleIsLoadingFromParent();

    WaitingItemUpdateRequest waitingItemUpdateRequest =
        WaitingItemUpdateRequest();
    waitingItemUpdateRequest.waitingId = waitingItem.waitingId;
    waitingItemUpdateRequest.action = ActionType.REPORT_ARRIVAL;

    try {
      await FirebaseAnalytics.instance.logEvent(
        name: "select_arrived",
        parameters: {
          "waitingItem": waitingItem.toJson().toString(),
        },
      );

      WaitingItem updatedItem =
      await _dineSeaterApiService.updateWaitingItem(waitingItemUpdateRequest);

      waitingItem.status = WaitingStatus.ARRIVED.name;
      await _waitingStorageService.updateWaiting(updatedItem);

      WaitingItemPublishRequest waitingItemPublishRequest =
      WaitingItemPublishRequest();
      waitingItemPublishRequest.waiting = updatedItem;
      await _dineSeaterApiService.publishWaitingItem(waitingItemPublishRequest);

    } catch (e) {
      final errorMessage = 'onTapConfirm error: $e';
      setErrorFromParent(errorMessage);
      rethrow;
    }

    toggleIsLoadingFromParent();

    stopWatchTimer.onStopTimer();

    notifyListeners();
  }


  Future<void> onTapCancel(WaitingItem waitingItem) async {
    stopWatchTimer.onStopTimer();

    toggleIsLoadingFromParent();

    WaitingItemUpdateRequest waitingItemUpdateRequest =
        WaitingItemUpdateRequest();
    waitingItemUpdateRequest.waitingId = waitingItem.waitingId;
    waitingItemUpdateRequest.action = ActionType.REPORT_CANCELLED;

    try {
      await FirebaseAnalytics.instance.logEvent(
        name: "select_cancel",
        parameters: {
          "waitingItem": waitingItem.toJson().toString(),
        },
      );

      WaitingItem updatedItem =
      await _dineSeaterApiService.updateWaitingItem(waitingItemUpdateRequest);

      waitingItem.status = WaitingStatus.CANCELLED.name;
      await _waitingStorageService.updateWaiting(updatedItem);

      WaitingItemPublishRequest waitingItemPublishRequest =
      WaitingItemPublishRequest();
      waitingItemPublishRequest.waiting = updatedItem;
      await _dineSeaterApiService.publishWaitingItem(waitingItemPublishRequest);

    } catch (e) {
      final errorMessage = 'onTapCancel error: $e';
      setErrorFromParent(errorMessage);
      rethrow;
    }

    toggleIsLoadingFromParent();

    notifyListeners();
  }

  Future<void> onTapBackToList(WaitingItem waitingItem) async {
    stopWatchTimer.onStopTimer();

    toggleIsLoadingFromParent();

    WaitingItemUpdateRequest waitingItemUpdateRequest =
        WaitingItemUpdateRequest();
    waitingItemUpdateRequest.waitingId = waitingItem.waitingId;
    waitingItemUpdateRequest.action = ActionType.REPORT_BACK_INITIAL_STATUS;

    try {
      await FirebaseAnalytics.instance.logEvent(
        name: "select_back_to_list",
        parameters: {
          "waitingItem": waitingItem.toJson().toString(),
        },
      );

      WaitingItem updatedItem =
      await _dineSeaterApiService.updateWaitingItem(waitingItemUpdateRequest);

      waitingItem.status = WaitingStatus.WAITING.name;
      await _waitingStorageService.updateWaiting(updatedItem);

      WaitingItemPublishRequest waitingItemPublishRequest =
      WaitingItemPublishRequest();
      waitingItemPublishRequest.waiting = updatedItem;
      await _dineSeaterApiService.publishWaitingItem(waitingItemPublishRequest);

    } catch (e) {
      final errorMessage = 'onTapBackToList error: $e';
      setErrorFromParent(errorMessage);
      rethrow;
    }

    toggleIsLoadingFromParent();

    notifyListeners();
  }
}
