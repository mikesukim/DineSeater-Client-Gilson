import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';

class PartySizeViewModel extends BaseViewModel {
  final _navigatorService = NavigationService();
  final _bottomSheetService = locator<BottomSheetService>();

  TextEditingController phoneController = TextEditingController();

  void showBottomSheet() {
    _bottomSheetService.showCustomSheet(
        variant: BottomSheetType.numKeypad,
        isScrollControlled: false,
        barrierColor: Colors.transparent);
  }

  void navigateBack() {
    _navigatorService.back();
  }
}
