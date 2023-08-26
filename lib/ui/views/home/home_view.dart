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
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      gilsonIconSmall,
                      verticalSpaceSmall,
                      const Text(
                        'Waitlist',
                        style: TextStyle(
                            fontSize: 20, fontWeight: semiBoldFontWeight),
                      ),
                      verticalSpaceMedium,
                      FractionallySizedBox(
                        widthFactor: 0.9,
                        child: ElevatedButton(
                            onPressed: () => print('hi'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kcPrimaryColor,
                                minimumSize: const Size(200, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25))
                                // elevation: 0
                                ),
                            child: const Text(
                              'Join the Waitlist',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: semiBoldFontWeight),
                            )),
                      )
                    ],
                  ),
                ),
                verticalSpaceMedium,
                Expanded(
                  flex: 2,
                  child: FractionallySizedBox(
                    widthFactor: 0.95,
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: mediumFontWeight),
                              ),
                              Text(
                                'Party size',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: mediumFontWeight),
                              )
                            ],
                          ),
                        ),
                        verticalSpaceSmall,
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: viewModel.waitlist.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 35,
                              color: (index == 0)
                                  ? kcLightGreyWithOpacity
                                  : Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 44.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      viewModel.waitlist[index].name,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: mediumFontWeight),
                                    ),
                                    Text(viewModel.waitlist[index].partySize
                                        .toString())
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                            indent: 16.0,
                            endIndent: 44.0,
                          ),
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
