import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.router.dart';
import '../../../model/waiting.dart';

class HomeViewModel extends BaseViewModel {
  final _navigationService = NavigationService();

  List<Waiting> waitingList = [
    Waiting(name: 'Ilsan Noh', partySize: 2, isGrill: false),
    Waiting(name: 'Seattle Kim', partySize: 3, isGrill: true),
    Waiting(name: 'Kayy', partySize: 1, isGrill: false),
    Waiting(name: 'Item', partySize: 6, isGrill: false),
    Waiting(name: 'Item', partySize: 3, isGrill: true),
    Waiting(name: 'Item', partySize: 2, isGrill: true)
  ];

  void navigateToMealTypeView() {
    Waiting waiting = Waiting();

    _navigationService.navigateTo(Routes.mealTypeView, arguments: waiting);
  }
}
