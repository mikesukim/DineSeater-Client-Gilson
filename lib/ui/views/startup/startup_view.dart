import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
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
        child: viewModel.hasError
            ? AlertDialog(
                // TODO: show proper error message
                title: Text(
                    'Oops! An error occurred while opening the app. ${viewModel.error.toString()}'),
              )
            : Stack(
                children: [
                  Center(
                      child: Image.asset(
                    'assets/Logo_Gilson.png',
                    scale: 1.5,
                  )),
                  Padding(
                    padding: EdgeInsets.all(Device.get().isTablet ? 20.0 : 8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'assets/Logo_DineSeater_white.png',
                        width: 75,
                      ),
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
