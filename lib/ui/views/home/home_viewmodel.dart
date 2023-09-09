import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = NavigationService();

  List<WaitList> waitlist = [
    WaitList(name: 'Ilsan Noh', partySize: 2),
    WaitList(name: 'Seattle Kim', partySize: 3),
    WaitList(name: 'Kayy', partySize: 1),
    WaitList(name: 'Item', partySize: 6),
    WaitList(name: 'Item', partySize: 3),
    WaitList(name: 'Item', partySize: 2)
  ];

  void navigateToMobileInputView() {
    _navigationService.navigateToMobileInputView();
  }
}

class WaitList {
  late String name;
  late int partySize;

  WaitList({required this.name, required this.partySize});
}
