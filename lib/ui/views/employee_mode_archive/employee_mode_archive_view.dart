import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import '../waiting_card/waiting_card_view.dart';
import 'employee_mode_archive_viewmodel.dart';


class EmployeeModeArchiveView
    extends StackedView<EmployeeModeArchiveViewModel> {
  const EmployeeModeArchiveView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    EmployeeModeArchiveViewModel viewModel,
    Widget? child,
  ) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(children: [
        Scaffold(
          backgroundColor: kcPrimaryColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 90,
            toolbarHeight: 40,
            title: Text(viewModel.getArchivedWaitingCount().toString()),
            leading: TextButton(
              onPressed: () => viewModel.navigateBack(),
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 16,
                  ),
                  Text(
                    'Back',
                    style: blackBackButtonStyle,
                  ),
                ],
              ),
            ),
          ),
          body: Stack(children: [
            SafeArea(
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
                                  itemCount: viewModel.getArchivedWaitingCount(),
                                  itemBuilder: (BuildContext context, int index) {
                                    return WaitingCardView(
                                      key: UniqueKey(),
                                      index,
                                      viewModel.getArchivedWaiting(index),
                                      isArchive: true,
                                      toggleIsLoadingFromParent:
                                          viewModel.toggleIsLoading,
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
            Visibility(
              visible: viewModel.isLoading,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )
          ]),
        ),
        Visibility(
            visible: viewModel.isLoading,
            child: const ModalBarrier(
              color: Colors.black26,
              dismissible: false,
            ))
      ]),
    );
  }

  @override
  EmployeeModeArchiveViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EmployeeModeArchiveViewModel();
}
