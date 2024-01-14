import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../../model/waiting.dart';

class PartySizeViewModel extends BaseViewModel {
  final _navigatorService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final partySizeFormKey = GlobalKey<FormState>();

  TextEditingController partySizeController = TextEditingController();
  Waiting waiting;

  PartySizeViewModel({required this.waiting}) {
    if (waiting.partySize != null) {
      partySizeController.text = waiting.partySize.toString();
    }
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.numKeypad,
        isScrollControlled: false,
        barrierColor: Colors.transparent);
  }

  void navigateBack() {
    _navigatorService.back();
  }

  void navigateToCustomerNameView() {
    waiting.partySize = int.parse(partySizeController.text);

    _navigatorService.navigateTo(Routes.customerNameView, arguments: waiting);
  }
}
