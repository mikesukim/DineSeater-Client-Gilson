import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../waiting_card/waiting_card_view.dart';
import 'employee_mode_archive_viewmodel.dart';

// TODO : when table is moving, item is not clickable
class EmployeeModeArchiveView
    extends StackedView<EmployeeModeArchiveViewModel> {
  const EmployeeModeArchiveView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EmployeeModeArchiveViewModel viewModel,
    Widget? child,
  ) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => EmployeeModeArchiveViewModel(),
        builder: (context, model, _) {
          return Scaffold(
            backgroundColor: kcPrimaryColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leadingWidth: 60,
              toolbarHeight: 40,
              title: Text(viewModel.getArchivedWaitingCount().toString()),
              leading: TextButton(
                onPressed: () => viewModel.navigateBack(),
                child: const Text(
                  'Back',
                  style: blackBackButtonStyle,
                ),
              ),
            ),
            body: SafeArea(
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: Device.get().isTablet ? 20.0 : 0.0),
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
                                  itemCount:
                                      viewModel.getArchivedWaitingCount(),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return WaitingCardView(
                                      index,
                                      viewModel.getArchivedWaiting(index),
                                      isArchive: true,
                                    );
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
        });
  }

  @override
  EmployeeModeArchiveViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EmployeeModeArchiveViewModel();
}
