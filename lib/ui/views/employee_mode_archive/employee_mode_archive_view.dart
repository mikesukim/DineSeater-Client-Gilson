import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
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
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 2.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    viewModel.waitingList[index]
                                                            .isGrill!
                                                        ? grillIconMedium
                                                        : mealIconMedium,
                                                  ],
                                                ),
                                              ),
                                            ),
                                            horizontalSpaceSmall,
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    viewModel.waitingList[index]
                                                        .name!,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    'Party size: ${viewModel.waitingList[index].partySize.toString()}',
                                                    style: const TextStyle(
                                                        fontSize: 18),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Column(
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () => viewModel
                                                            .onTapBackToList(),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                elevation: 0,
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10), // <-- Radius
                                                                ),
                                                                backgroundColor:
                                                                    kcMediumGrey),
                                                        child: const Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      10.0,
                                                                  horizontal:
                                                                      16.0),
                                                          child: Text(
                                                            'Back to list',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                          onPressed: () =>
                                                              viewModel
                                                                  .onTapEditCard(),
                                                          child: const Text(
                                                            'Edit card',
                                                            style: TextStyle(
                                                                color:
                                                                    kcMediumGrey),
                                                          ))
                                                    ],
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
  }

  @override
  EmployeeModeArchiveViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      EmployeeModeArchiveViewModel();
}
