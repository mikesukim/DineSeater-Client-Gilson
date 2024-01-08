import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  // TODO: check all UIs to improve
  // TODO: show total number of waitings
  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, _) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: Device.get().isTablet ? 20.0 : 8.0),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: gilsonIconSmall,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                              onPressed: viewModel.navigateToEmployeeModeView,
                              icon: const Icon(Icons.manage_accounts_outlined)),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 10.0,
                    ),
                    verticalSpaceSmall,
                    Expanded(
                      child: FractionallySizedBox(
                        widthFactor: 0.9,
                        child: Column(
                          children: [
                            const Text(
                              'Waitlist',
                              style: TextStyle(
                                  fontSize: 26, fontWeight: mediumFontWeight),
                            ),
                            verticalSpaceMedium,
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 50),
                                      Text(
                                        'Name',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: semiBoldFontWeight),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Party size',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: semiBoldFontWeight),
                                  )
                                ],
                              ),
                            ),
                            verticalSpaceMedium,
                            Expanded(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemCount: viewModel.getWaitingCount(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    height: 60,
                                    color: (index == 0)
                                        ? kcLightPrimaryColor
                                        : Colors.transparent,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: (viewModel
                                                .getWaiting(index)
                                                .isGrill!)
                                            ? 14.0
                                            : 16.0,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              (viewModel
                                                      .getWaiting(index)
                                                      .isGrill!)
                                                  ? grillIconSmall
                                                  : mealIconSmall,
                                              (viewModel
                                                      .getWaiting(index)
                                                      .isGrill!)
                                                  ? const SizedBox(width: 16)
                                                  : const SizedBox(width: 20),
                                              Text(
                                                viewModel
                                                    .getWaiting(index)
                                                    .name!,
                                                style: const TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        mediumFontWeight),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                viewModel
                                                    .getWaiting(index)
                                                    .partySize
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 17),
                                              ),
                                              const SizedBox(
                                                width: 50,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(
                                  color: Colors.transparent,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: ElevatedButton(
                          onPressed: () => viewModel.navigateToMealTypeView(),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kcPrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              elevation: 0),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Join the Waitlist',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: semiBoldFontWeight),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
