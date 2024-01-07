import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/waiting.dart';

class EmployeeModeArchiveViewModel extends BaseViewModel {
  final _navigatorService = NavigationService();

  List<Waiting> waitingList = [
    Waiting(name: 'Ilsan Noh', partySize: 2, isGrill: false),
    Waiting(name: 'Seattle Kim', partySize: 3, isGrill: true),
  ];

  void navigateBack() {
    _navigatorService.back();
  }
}
