import 'package:dineseater_client_gilson/model/waiting_item.dart';
import 'package:localstorage/localstorage.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class WaitingStorageService with ListenableServiceMixin {
  var logger = Logger();
  late ReactiveList<WaitingItem> _waitings =
      ReactiveList<WaitingItem>();
  final LocalStorage _waitingStorage = LocalStorage('waitingStorage');
  final String _waitingsKey = 'waitings';

  WaitingStorageService() {
    listenToReactiveValues([_waitings]);
  }

  ReactiveList<WaitingItem> get waitings => _waitings;

  // init WaitingStorageService
  Future<void> init() async {
    await _waitingStorage.ready;

    try {
      // load waitings from storage
      final waitingsFromStorageDynamic = await _waitingStorage.getItem(_waitingsKey);
      if (waitingsFromStorageDynamic != null) {
        final waitingsFromStorage = Map<String, WaitingItem>.fromEntries(
          (waitingsFromStorageDynamic as Map<String, dynamic>).entries.map(
                (e) => MapEntry(e.key, WaitingItem.fromJson(e.value)),
          ),
        );
        _waitings = ReactiveList.from(waitingsFromStorage.values);
      }
    } catch (e) {
      logger.e('loading waitings from storage error: $e');
      rethrow;
    }
    logger.i('loading waitings from storage completed');
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

  Future<void> removeWaitingFromStorage(String waitingId) async {
    final waitingsFromStorageDynamic =
        await _waitingStorage.getItem(_waitingsKey);
    if (waitingsFromStorageDynamic != null) {
      waitingsFromStorageDynamic.remove(waitingId);
      await _waitingStorage.setItem(_waitingsKey, waitingsFromStorageDynamic);
    }
  }
}
