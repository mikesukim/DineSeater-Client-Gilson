import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(bottom: Device.get().isTablet ? 20.0 : 0.0),
          child: Center(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    gilsonIconSmall,
                    verticalSpaceSmall,
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: ElevatedButton(
                          onPressed: () =>
                              viewModel.navigateToMobileInputView(),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kcPrimaryColor,
                              minimumSize: const Size(200, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25)),
                              elevation: 0),
                          child: const Text(
                            'Join the Waitlist',
                            style: TextStyle(
                                fontSize: 16, fontWeight: semiBoldFontWeight),
                          )),
                    )
                  ],
                ),
                verticalSpaceSmall,
                const Divider(
                  height: 40.0,
                ),
                Expanded(
                  flex: 2,
                  child: FractionallySizedBox(
                    widthFactor: 0.95,
                    child: Column(
                      children: [
                        const Text(
                          'Waitlist',
                          style: TextStyle(
                              fontSize: 24, fontWeight: mediumFontWeight),
                        ),
                        verticalSpaceMedium,
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 50),
                                  Text(
                                    'Name',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: semiBoldFontWeight),
                                  ),
                                ],
                              ),
                              Text(
                                'Party size',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: semiBoldFontWeight),
                              )
                            ],
                          ),
                        ),
                        verticalSpaceSmall,
                        FractionallySizedBox(
                          widthFactor: 0.95,
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: viewModel.waitlist.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 50,
                                  color: (index == 0)
                                      ? kcLightPrimaryColor
                                      : Colors.transparent,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: (viewModel.waitlist[index].isGrill)
                                          ? 14.0
                                          : 16.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            (viewModel.waitlist[index].isGrill)
                                                ? grillIconSmall
                                                : mealIconSmall,
                                            (viewModel.waitlist[index].isGrill)
                                                ? const SizedBox(width: 16)
                                                : const SizedBox(width: 20),
                                            Text(
                                              viewModel.waitlist[index].name,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: mediumFontWeight),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(viewModel
                                                .waitlist[index].partySize
                                                .toString()),
                                            const SizedBox(
                                              width: 30,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HomeViewModel();
}
