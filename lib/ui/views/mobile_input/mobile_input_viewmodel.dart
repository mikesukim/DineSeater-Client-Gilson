import 'package:dineseater_client_gilson/app/app.bottomsheets.dart';
import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../model/waiting.dart';

class MobileInputViewModel extends BaseViewModel {
  final _navigatorService = locator<NavigationService>();
  final _bottomSheetService = locator<BottomSheetService>();
  final mobileInputFormKey = GlobalKey<FormState>();

  Waiting waiting;

  TextEditingController phoneController = TextEditingController();

  MobileInputViewModel({required this.waiting}) {
    if (waiting.mobileNumber != null) {
      String formattedMobileNumber = waiting.mobileNumber!;
      formattedMobileNumber =
          '(${formattedMobileNumber.substring(2, 5)}) ${formattedMobileNumber.substring(5, 8)} ${formattedMobileNumber.substring(8, 12)}';
      phoneController.text = formattedMobileNumber;
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

  void navigateToConfirm1view() {
    String mobileNumber = phoneController.text.replaceAll('(', '');
    mobileNumber = mobileNumber.replaceAll(')', '');
    mobileNumber = mobileNumber.replaceAll(' ', '');
    mobileNumber = '+1$mobileNumber';
    waiting.mobileNumber = mobileNumber;

    _navigatorService.navigateTo(Routes.confirm1View, arguments: waiting);
  }
}
