import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/waiting.dart';

class EmployeeModeViewModel extends BaseViewModel {
  final _navigatorService = NavigationService();

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

  void onTapCard(int index) {
    print('$index is tapped');
  }

  void navigateBack() {
    _navigatorService.back();
  }

  void navigateToArchiveView() {
    _navigatorService.navigateToEmployeeModeArchiveView();
  }
}
