import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CustomerNameViewModel extends BaseViewModel {
  final _navigatorService = NavigationService();

  TextEditingController nameController = TextEditingController();

  void navigateBack() {
    _navigatorService.back();
  }

  void navigateToMobileInputView() {
    _navigatorService.navigateToMobileInputView();
  }
}
