import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class MobileInputViewModel extends BaseViewModel {
  final _navigatorService = NavigationService();
  TextEditingController phoneController = TextEditingController(text: '+1 ');

  void navigateBack() {
    _navigatorService.back();
  }
}
