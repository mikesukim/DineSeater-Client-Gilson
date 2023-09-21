import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = NavigationService();

  List<WaitList> waitlist = [
    WaitList(name: 'Ilsan Noh', partySize: 2, isGrill: false),
    WaitList(name: 'Seattle Kim', partySize: 3, isGrill: true),
    WaitList(name: 'Kayy', partySize: 1, isGrill: false),
    WaitList(name: 'Item', partySize: 6, isGrill: false),
    WaitList(name: 'Item', partySize: 3, isGrill: true),
    WaitList(name: 'Item', partySize: 2, isGrill: true)
  ];

  void navigateToMobileInputView() {
    _navigationService.navigateToMobileInputView();
  }
}

class WaitList {
  late String name;
  late int partySize;
  late bool isGrill;

  WaitList(
      {required this.name, required this.partySize, required this.isGrill});
}
