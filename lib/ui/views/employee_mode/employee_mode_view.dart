import 'package:dineseater_client_gilson/ui/views/waiting_card/waiting_card_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'employee_mode_viewmodel.dart';

class EmployeeModeView extends StackedView<EmployeeModeViewModel> {
  const EmployeeModeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EmployeeModeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcPrimaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 60,
        toolbarHeight: 40,
        leading: TextButton(
          onPressed: () => viewModel.navigateBack(),
          child: const Text(
            'Back',
            style: blackBackButtonStyle,
          ),
        ),
        actions: [
          IconButton(
              onPressed: viewModel.navigateToArchiveView,
              icon: const Icon(
                Icons.archive_outlined,
                color: Colors.black,
                size: 30,
              )),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: Device.get().isTablet ? 20.0 : 0.0),
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      gilsonIconSmall,
                      verticalSpaceMedium,
                      Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: viewModel.waitingList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return WaitingCardView(
                                  index, viewModel.waitingList[index]);
                            }),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  EmployeeModeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EmployeeModeViewModel();
}
