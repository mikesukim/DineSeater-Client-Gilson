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
            actions: [
              IconButton(
                  onPressed: viewModel.navigateToArchiveView,
                  icon: const Icon(
                    Icons.archive,
                    color: Colors.black,
                    size: 30,
                  )),
            ],
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
                            Container(
                              padding: EdgeInsets.zero,
                              decoration: const BoxDecoration(
                                color: kcToggleButtonColor,
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: ToggleButtons(
                                splashColor: Colors.transparent,
                                borderWidth: 0,
                                fillColor: Colors.white,
                                color: kcVeryLightGrey,
                                selectedColor: kcPrimaryColor,
                                borderRadius: BorderRadius.circular(10),
                                constraints: BoxConstraints(
                                  minHeight: 50.0,
                                  minWidth: (MediaQuery.of(context).size.width - 26) / 2,
                                ),
                                isSelected: viewModel.isSelected,
                                onPressed: (int index) =>
                                    viewModel.onTapToggleButton(index),
                                children: viewModel.toggleSelections,
                              ),
                            ),
                            verticalSpaceSmall,
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: viewModel.getWaitingCount,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return WaitingCardView(
                                        key: UniqueKey(),
                                        index,
                                        viewModel.getWaitingItem(index),
                                        toggleIsLoadingFromParent:
                                            viewModel.toggleIsLoading);
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
  EmployeeModeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EmployeeModeViewModel();
}
