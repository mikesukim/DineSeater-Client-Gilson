import 'package:dineseater_client_gilson/model/waiting_item.dart';

class Waiting {
  String? name;
  int? partySize;
  bool? isGrill;
  String? mobileNumber;

  Waiting({this.name, this.partySize, this.isGrill, this.mobileNumber});

  Waiting.from(WaitingItem waitingItem) {
    name = waitingItem.name;
    partySize = waitingItem.numberOfCustomers;
    isGrill = waitingItem.detailAttribute.isGrill;
    mobileNumber = waitingItem.phoneNumber;
  }
}
