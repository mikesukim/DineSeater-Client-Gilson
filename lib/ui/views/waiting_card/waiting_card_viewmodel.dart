import 'package:stacked/stacked.dart';

class WaitingCardViewModel extends BaseViewModel {
  bool isTableReady = false;
  bool isTimerEnd = false;

  void onTapTableReady(int index) {
    isTableReady = true;

    notifyListeners();
  }

  void onTimerEnd(int index) {
    isTimerEnd = true;

    notifyListeners();
  }

  void onTapCancel(int index) {
    isTableReady = false;

    // TODO: archive

    notifyListeners();
  }

  void onTapConfirm(int index) {
    isTableReady = false;

    // TODO: archive

    notifyListeners();
  }

  void onTapBackToList() {
    print('back to list');
  }

  void onTapEditCard() {
    print('edit card');
  }
}
