import 'package:dineseater_client_gilson/model/waiting_item.dart';
import 'package:stacked/stacked.dart';

class WaitingStorageService with ListenableServiceMixin {
  // TODO : consider to switch to map for better performance
  final ReactiveValue<List<WaitingItem>> _waitings =
  ReactiveValue<List<WaitingItem>>([]);

  WaitingStorageService() {
    listenToReactiveValues([_waitings]);
  }

  List<WaitingItem> get waitings => _waitings.value;

  void addWaiting(WaitingItem waiting) {
    // TODO : add to local storage
    _waitings.value = [..._waitings.value, waiting];
  }

  void removeWaiting(String waitingId) {
    // TODO : remove from local storage as well
    _waitings.value = _waitings.value
        .where((element) => element.waitingId != waitingId)
        .toList();
  }
}

