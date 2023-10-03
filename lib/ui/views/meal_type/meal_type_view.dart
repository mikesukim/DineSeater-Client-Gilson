import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'meal_type_viewmodel.dart';

class MealTypeView extends StackedView<MealTypeViewModel> {
  const MealTypeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MealTypeViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => viewModel.navigateBack(),
                    child: const Text(
                      'Back',
                      style: backButtonStyle,
                    ),
                  ),
                ),
                Expanded(
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            gilsonIconSmall,
                            verticalSpaceSmall,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: (viewModel.selectedButton == 0)
                                                ? kcPrimaryColor
                                                : kcLightGreyWithOpacity,
                                            width: 2),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))),
                                    height: 170,
                                    width: 170,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          maxRadius: 40,
                                          backgroundColor:
                                              (viewModel.selectedButton == 0)
                                                  ? kcPrimaryColor
                                                  : kcLightGreyWithOpacity,
                                          child: Image.asset(
                                            'assets/meal.png',
                                            scale: 2,
                                            color: (viewModel.selectedButton == 0)
                                                ? Colors.white
                                                : kcVeryLightGrey,
                                          ),
                                        ),
                                        verticalSpaceMedium,
                                        Text(
                                          'Regular Meal',
                                          style: TextStyle(
                                              color: (viewModel.selectedButton == 0)
                                                  ? Colors.black
                                                  : kcVeryLightGrey,
                                              fontSize: 17,
                                              fontWeight:
                                                  (viewModel.selectedButton == 0)
                                                      ? semiBoldFontWeight
                                                      : FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  onTap: () => viewModel.onTapMealType(0),
                                ),
                                GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: (viewModel.selectedButton == 1)
                                                ? kcPrimaryColor
                                                : kcLightGreyWithOpacity,
                                            width: 2),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))),
                                    height: 170,
                                    width: 170,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          maxRadius: 40,
                                          backgroundColor:
                                              (viewModel.selectedButton == 1)
                                                  ? kcPrimaryColor
                                                  : kcLightGreyWithOpacity,
                                          child: Image.asset(
                                            'assets/grill.png',
                                            color: (viewModel.selectedButton == 1)
                                                ? Colors.white
                                                : kcVeryLightGrey,
                                            scale: 2,
                                          ),
                                        ),
                                        verticalSpaceMedium,
                                        Text(
                                          'Barbecue Grill',
                                          style: TextStyle(
                                              color: (viewModel.selectedButton == 1)
                                                  ? Colors.black
                                                  : kcVeryLightGrey,
                                              fontSize: 17,
                                              fontWeight:
                                                  (viewModel.selectedButton == 1)
                                                      ? semiBoldFontWeight
                                                      : FontWeight.normal),
                                        )
                                      ],
                                    ),
                                  ),
                                  onTap: () => viewModel.onTapMealType(1),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Estimated wait: 15-25 minutes',
                              style: subText,
                            ),
                            verticalSpaceMedium,
                            //TODO: set button max width instead of percentage
                            FractionallySizedBox(
                              widthFactor: 1.0,
                              child: ElevatedButton(
                                  onPressed: () => print('hi'),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: kcPrimaryColor,
                                      minimumSize: const Size(200, 50),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      elevation: 0),
                                  child: const Text(
                                    'Next',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: semiBoldFontWeight),
                                  )),
                            ),
                          ],
                        ),
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
  MealTypeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MealTypeViewModel();
}
