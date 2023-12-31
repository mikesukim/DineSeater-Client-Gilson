import 'package:dineseater_client_gilson/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/waiting.dart';

class CustomerNameViewModel extends BaseViewModel {
  final _navigatorService = NavigationService();
  final nameFormKey = GlobalKey<FormState>();

  Waiting waiting;

  TextEditingController nameController = TextEditingController();

  CustomerNameViewModel({required this.waiting}) {
    if (waiting.name != null) {
      nameController.text = waiting.name!;
    }
  }

  void navigateBack() {
    _navigatorService.back();
  }

  void navigateToMobileInputView() {
    waiting.name = nameController.text;

    _navigatorService.navigateTo(Routes.mobileInputView, arguments: waiting);
  }
}
