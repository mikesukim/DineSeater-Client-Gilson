import 'package:dineseater_client_gilson/model/waiting_item.dart';
import 'package:localstorage/localstorage.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import '../model/waiting_status.dart';

class WaitingStorageService with ListenableServiceMixin {
  var logger = Logger();
  late ReactiveList<WaitingItem> _waitings = ReactiveList<WaitingItem>();
  late ReactiveList<WaitingItem> _archivedWaitings =
      ReactiveList<WaitingItem>();
  // currently data is saved to storage but not used
  final LocalStorage _waitingStorage = LocalStorage('waitingStorage');
  final String _waitingsKey = 'waitings';

  // This is a safeguard to avoid redundant updates of waiting items.
  // When a device triggers an update or adds a WaitingItem, same device may still receive the notification
  // that contains the same WaitingItem, for which the device has already updated locally.
  WaitingItem? _lastModifiedWaitingItem;

  WaitingStorageService() {
    listenToReactiveValues([_waitings]);
  }

  ReactiveList<WaitingItem> get waitings => _waitings;
  ReactiveList<WaitingItem> get archivedWaitings => _archivedWaitings;

  // init WaitingStorageService
  Future<void> init() async {
    await _waitingStorage.ready;
  }

// resetWaitingsAs should only be called only once when app is initialized
  Future<void> resetWaitingsAs(List<WaitingItem> waitings) async {
    //await _addWaitingListToStorage(waitings);
    List<WaitingItem> archivedWaitings = [];
    List<WaitingItem> newWaitings = [];
    for (var waiting in waitings) {
      if (waiting.status == 'arrived' || waiting.status == 'missed') {
        archivedWaitings.add(waiting);
      } else {
        newWaitings.add(waiting);
      }
    }
    _waitings = ReactiveList.from(newWaitings);
    _archivedWaitings = ReactiveList.from(archivedWaitings);
    _waitings.sort(compareByLastModified);
    _archivedWaitings.sort(compareByLastModified);
    logger.i('update completed');
    notifyListeners();
  }

  // updateWaitings should only be called only once when app is initialized
  Future<void> updateWaitings(List<WaitingItem> waitings) async {
    //await _addWaitingListToStorage(waitings);
    for (var waiting in waitings) {
      if (waiting.status == WaitingStatus.ARRIVED.name ||
          waiting.status == WaitingStatus.MISSED.name) {
        final index = _archivedWaitings
            .indexWhere((element) => element.waitingId == waiting.waitingId);
        if (index != -1) {
          _archivedWaitings[index] = waiting;
        } else {
          _archivedWaitings.add(waiting);
        }
      } else {
        final index = _waitings
            .indexWhere((element) => element.waitingId == waiting.waitingId);
        if (index != -1) {
          _waitings[index] = waiting;
        } else {
          _waitings.add(waiting);
        }
      }
    }
    logger.i('update completed');
    _waitings.sort(compareByLastModified);
    _archivedWaitings.sort(compareByLastModified);
    notifyListeners();
  }

  WaitingItem getWaiting(int index) {
    return _waitings[index];
  }

  WaitingItem getArchivedWaiting(int index) {
    return _archivedWaitings[index];
  }

  Future<void> addWaiting(WaitingItem waiting) async {
    if (_isLocallyUpdatedAlready(waiting)) {
      return;
    }
    //await _addWaitingToStorage(waiting);
    _waitings.add(waiting);
    _lastModifiedWaitingItem = waiting;
    _waitings.sort(compareByLastModified);
    _archivedWaitings.sort(compareByLastModified);
    logger.i('addWaiting completed');
    notifyListeners();
  }

  // update waiting
  Future<void> updateWaiting(WaitingItem waiting) async {
    logger.i('updateWaiting : ${waiting.name} , ${waiting.status}');
    // if (_isLocallyUpdatedAlready(waiting)) {
    //   return;
    // }
    //await _addWaitingToStorage(waiting);
    if (waiting.status == WaitingStatus.ARRIVED.name ||
        waiting.status == WaitingStatus.MISSED.name) {
      final index = _archivedWaitings
          .indexWhere((element) => element.waitingId == waiting.waitingId);
      if (index != -1) {
        _archivedWaitings[index] = waiting;
      } else {
        _archivedWaitings.add(waiting);
      }
      await removeWaitingAtWaitings(waiting.waitingId);
    } else {
      final index = _waitings
          .indexWhere((element) => element.waitingId == waiting.waitingId);
      if (index != -1) {
        _waitings[index] = waiting;
      } else {
        _waitings.add(waiting);
      }
      await removeWaitingAtArchivedWaitings(waiting.waitingId);
    }
    _lastModifiedWaitingItem = waiting;
    // TODO : possibly can make it more efficient, by knowing exact index to insert when adding
    _waitings.sort(compareByLastModified);
    _archivedWaitings.sort(compareByLastModified);
    logger.i('update completed');
    notifyListeners();
  }

  Future<void> removeWaiting(String waitingId) async {
    //await _removeWaitingFromStorage(waitingId);
    _waitings.removeWhere((element) => element.waitingId == waitingId);
    _archivedWaitings.removeWhere((element) => element.waitingId == waitingId);
    logger.i('removeWaiting completed');
    notifyListeners();
  }

  Future<void> removeWaitingAtWaitings(String waitingId) async {
    //await _removeWaitingFromStorage(waitingId);
    _waitings.removeWhere((element) => element.waitingId == waitingId);
    logger.i('removeWaitingAtWaitings completed');
    notifyListeners();
  }

  Future<void> removeWaitingAtArchivedWaitings(String waitingId) async {
    //await _removeWaitingFromStorage(waitingId);
    _archivedWaitings.removeWhere((element) => element.waitingId == waitingId);
    logger.i('removeWaitingAtArchivedWaitings completed');
    notifyListeners();
  }

  Future<void> _addWaitingToStorage(WaitingItem waiting) async {
    final waitingsFromStorageDynamic =
        await _waitingStorage.getItem(_waitingsKey);
    if (waitingsFromStorageDynamic != null) {
      waitingsFromStorageDynamic[waiting.waitingId] = waiting;
      await _waitingStorage.setItem(_waitingsKey, waitingsFromStorageDynamic);
    } else {
      await _waitingStorage.setItem(_waitingsKey, {waiting.waitingId: waiting});
    }
  }

  Future<void> _addWaitingListToStorage(List<WaitingItem> waitings) async {
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

  Future<void> _removeWaitingFromStorage(String waitingId) async {
    final waitingsFromStorageDynamic =
        await _waitingStorage.getItem(_waitingsKey);
    if (waitingsFromStorageDynamic != null) {
      waitingsFromStorageDynamic.remove(waitingId);
      await _waitingStorage.setItem(_waitingsKey, waitingsFromStorageDynamic);
    }
  }

  bool _isLocallyUpdatedAlready(WaitingItem newWaitingItem) {
    if (_lastModifiedWaitingItem == null) {
      return false;
    }
    DateTime lastModifiedWaitingItemDateTime =
        DateTime.parse(_lastModifiedWaitingItem!.lastModified);
    DateTime newWaitingItemDateTime =
        DateTime.parse(newWaitingItem.lastModified);
    if (newWaitingItemDateTime.isAfter(lastModifiedWaitingItemDateTime)) {
      return false;
    }
    logger.i('newWaitingItem is already updated locally');
    return true;
  }

  // Custom comparison function for sorting based on lastModified DateTime
  int compareByLastModified(WaitingItem a, WaitingItem b) {
    DateTime aDateTime = DateTime.parse(a.dateCreated);
    DateTime bDateTime = DateTime.parse(b.dateCreated);
    return aDateTime.compareTo(bDateTime);
  }
}
