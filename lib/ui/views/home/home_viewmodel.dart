import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  List<WaitList> waitlist = [
    WaitList(name: 'Ilsan Noh', partySize: 2),
    WaitList(name: 'Seattle Kim', partySize: 3),
    WaitList(name: 'Kayy', partySize: 1),
    WaitList(name: 'Item', partySize: 6),
    WaitList(name: 'Item', partySize: 3),
    WaitList(name: 'Item', partySize: 2)
  ];
}

class WaitList {
  late String name;
  late int partySize;

  WaitList({required this.name, required this.partySize});
}
