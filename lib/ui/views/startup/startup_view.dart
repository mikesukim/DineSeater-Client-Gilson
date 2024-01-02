import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcPrimaryColor,
      body: SafeArea(
        // TODO : switch to popup and block the process
        child: viewModel.hasError
            ? Text(viewModel.error.toString())
            : Stack(
                children: [
                  Center(child: Image.asset('assets/Logo_Gilson.png')),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/Logo_DineSeater_white.png',
                      width: 75,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
