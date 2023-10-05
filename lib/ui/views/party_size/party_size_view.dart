import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'party_size_viewmodel.dart';

class PartySizeView extends StackedView<PartySizeViewModel> {
  const PartySizeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    PartySizeViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                            const Text(
                              'How many people in your party?',
                              style: mainText,
                            ),
                            verticalSpaceTiny,
                            const FractionallySizedBox(
                              widthFactor: 0.7,
                              child: Text(
                                'For parties larger than 7, please speak with our restaurant staff.',
                                style: subText,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            verticalSpaceMedium,
                            MaterialButton(
                              onPressed: viewModel.showBottomSheet,
                              child: Text('show'),
                            ),
                            TextFormField(
                              controller: viewModel.phoneController,
                              keyboardType: TextInputType.phone,
                              //TODO: validator
                              validator: (String? value) {
                                print(value);
                                String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                RegExp regExp = RegExp(pattern);
                                if (value!.isEmpty) {
                                  return 'Please enter mobile number.';
                                } else if (!regExp.hasMatch(value)) {
                                  return 'Please enter valid mobile number.';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  hintText: '1',
                                  hintStyle: inputHintTextStyle,
                                  // filled: true,
                                  // fillColor: kcInputBackgroundColor,
                                  enabledBorder: inputBorderStyle,
                                  focusedBorder: inputBorderStyle),
                            ),
                            // verticalSpaceMedium,
                            // const SizedBox(height: 90.0),
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
  PartySizeViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      PartySizeViewModel();
}
