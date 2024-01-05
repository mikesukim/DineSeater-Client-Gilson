import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
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
                              return _buildCard(viewModel, index);
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

  Widget _buildCard(EmployeeModeViewModel viewModel, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Card(
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: viewModel.isTimerEnd[index]
                    ? Colors.red
                    : Colors.transparent,
                width: 10),
            borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: () => viewModel.onTapCard(index),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            viewModel.waitingList[index].isGrill!
                                ? grillIconMedium
                                : mealIconMedium,
                            if (viewModel.isTableReady[index])
                              TimerCountdown(
                                endTime: DateTime.now()
                                    .add(const Duration(seconds: 10
                                        //       minutes: 5
                                        )),
                                format: CountDownTimerFormat.minutesSeconds,
                                enableDescriptions: false,
                                spacerWidth: 2,
                                onEnd: () =>
                                    // print('object')
                                    viewModel.onTimerEnd(index),
                              )
                          ],
                        ),
                      ),
                    ),
                    horizontalSpaceSmall,
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            viewModel.waitingList[index].name!,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            'Party size: ${viewModel.waitingList[index].partySize.toString()}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    if (!viewModel.isTableReady[index])
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ElevatedButton(
                              onPressed: () => viewModel.onTapTableReady(index),
                              style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(10), // <-- Radius
                                  ),
                                  backgroundColor: kcPrimaryColor),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Text(
                                  'Table Ready',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          )),
                    if (viewModel.isTableReady[index])
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: employeeModeCancel,
                              iconSize: 60,
                              onPressed: () =>
                                  // print('object')
                                  viewModel.onTapCancel(index),
                            ),
                          )),
                    if (viewModel.isTableReady[index])
                      Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              icon: employeeModeConfirm,
                              iconSize: 60,
                              onPressed: () => viewModel.onTapConfirm(index),
                            ),
                          )),
                  ],
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
