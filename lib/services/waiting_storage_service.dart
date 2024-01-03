import 'package:dineseater_client_gilson/model/waiting_item.dart';
import 'package:localstorage/localstorage.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class WaitingStorageService with ListenableServiceMixin {
  var logger = Logger();
  late ReactiveList<WaitingItem> _waitings = ReactiveList<WaitingItem>();
  final LocalStorage _waitingStorage = LocalStorage('waitingStorage');
  final String _waitingsKey = 'waitings';

  WaitingStorageService() {
    listenToReactiveValues([_waitings]);
  }

  ReactiveList<WaitingItem> get waitings => _waitings;

  // init WaitingStorageService
  Future<void> init() async {
    await _waitingStorage.ready;
  }

  Future<void> resetWaitingsAs(List<WaitingItem> waitings) async {
    await addWaitingListToStorage(waitings);
    _waitings = ReactiveList.from(waitings);
    logger.i('update completed');
    notifyListeners();
  }

  Future<void> updateWaitings(List<WaitingItem> waitings) async {
    await addWaitingListToStorage(waitings);
    for (var waiting in waitings) {
      final index = _waitings
          .indexWhere((element) => element.waitingId == waiting.waitingId);
      if (index != -1) {
        _waitings[index] = waiting;
      } else {
        _waitings.add(waiting);
      }
    }
    logger.i('update completed');
    notifyListeners();
  }

  WaitingItem getWaiting(int index) {
    return _waitings[index];
  }

  Future<void> addWaiting(WaitingItem waiting) async {
    await addWaitingToStorage(waiting);
    _waitings.add(waiting);
    logger.i('addWaiting completed');
    notifyListeners();
  }

  Future<void> removeWaiting(String waitingId) async {
    await removeWaitingFromStorage(waitingId);
    _waitings.removeWhere((element) => element.waitingId == waitingId);
    logger.i('removeWaiting completed');
    notifyListeners();
  }

  Future<void> addWaitingToStorage(WaitingItem waiting) async {
    final waitingsFromStorageDynamic =
        await _waitingStorage.getItem(_waitingsKey);
    if (waitingsFromStorageDynamic != null) {
      waitingsFromStorageDynamic[waiting.waitingId] = waiting;
      await _waitingStorage.setItem(_waitingsKey, waitingsFromStorageDynamic);
    } else {
      await _waitingStorage.setItem(_waitingsKey, {waiting.waitingId: waiting});
    }
  }

  Future<void> addWaitingListToStorage(List<WaitingItem> waitings) async {
    final waitingsFromStorageDynamic =
        await _waitingStorage.getItem(_waitingsKey);
    if (waitingsFromStorageDynamic != null) {
      for (var waiting in waitings) {
        waitingsFromStorageDynamic[waiting.waitingId] = waiting;
      }
      await _waitingStorage.setItem(_waitingsKey, waitingsFromStorageDynamic);
    } else {
      Map<String, WaitingItem> waitingsMap = {};
      for (var waiting in waitings) {
        waitingsMap[waiting.waitingId] = waiting;
      }
      await _waitingStorage.setItem(_waitingsKey, waitingsMap);
    }
  }

  Future<void> removeWaitingFromStorage(String waitingId) async {
    final waitingsFromStorageDynamic =
        await _waitingStorage.getItem(_waitingsKey);
    if (waitingsFromStorageDynamic != null) {
      waitingsFromStorageDynamic.remove(waitingId);
      await _waitingStorage.setItem(_waitingsKey, waitingsFromStorageDynamic);
    }
  }
}
