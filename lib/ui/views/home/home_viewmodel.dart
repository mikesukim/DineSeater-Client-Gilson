import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.router.dart';
import '../../../model/waiting.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = NavigationService();

  List<Waiting> waitingList = [
    Waiting(name: 'Ilsan Noh', partySize: 2, isGrill: false),
    Waiting(name: 'Seattle Kim', partySize: 3, isGrill: true),
    Waiting(name: 'Kay K', partySize: 1, isGrill: false),
    Waiting(name: 'Seeun P', partySize: 6, isGrill: false),
    Waiting(name: 'Yulmoo Mom', partySize: 3, isGrill: true),
    Waiting(name: 'Aron Cho', partySize: 2, isGrill: true),
    Waiting(name: 'Ilsan Noh', partySize: 2, isGrill: false),
    Waiting(name: 'Seattle Kim', partySize: 3, isGrill: true),
    Waiting(name: 'Kay K', partySize: 1, isGrill: false),
    Waiting(name: 'Seeun P', partySize: 6, isGrill: false),
    Waiting(name: 'Yulmoo Mom', partySize: 3, isGrill: true),
    Waiting(name: 'Aron Cho', partySize: 2, isGrill: true)
  ];

  void navigateToEmployeeModeView() {
    _navigationService.navigateToEmployeeModeView();
  }

  void navigateToMealTypeView() {
    Waiting waiting = Waiting();

    _navigationService.navigateTo(Routes.mealTypeView, arguments: waiting);
  }
}
