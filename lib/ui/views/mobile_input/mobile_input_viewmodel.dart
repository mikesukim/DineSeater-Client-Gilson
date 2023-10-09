import 'package:dineseater_client_gilson/app/app.bottomsheets.dart';
import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class MobileInputViewModel extends BaseViewModel {
  final _navigatorService = NavigationService();
  final _bottomSheetService = locator<BottomSheetService>();

  TextEditingController phoneController = TextEditingController();

  void navigateBack() {
    _navigatorService.back();
  }

  void navigateToConfirm1view() {
    _navigatorService.navigateToConfirm1View();
  }

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.numKeypad,
        isScrollControlled: false,
        barrierColor: Colors.transparent);
  }
}
