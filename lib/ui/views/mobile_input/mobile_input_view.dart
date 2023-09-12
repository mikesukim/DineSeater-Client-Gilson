import 'package:dineseater_client_gilson/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:stacked/stacked.dart';

import '../../common/ui_helpers.dart';
import 'mobile_input_viewmodel.dart';

class MobileInputView extends StackedView<MobileInputViewModel> {
  const MobileInputView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MobileInputViewModel viewModel,
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
                            const Text(
                              'What\'s your mobile number?',
                              style: mainText,
                            ),
                            verticalSpaceTiny,
                            const Text(
                              'You will receive texts about your visit.',
                              style: subText,
                            ),
                            verticalSpaceMedium,
                            MaterialButton(onPressed: viewModel.showBottomSheet, child: Text('show'),),
                            TextFormField(
                              //TODO: phoneController.value length <= 3, disable delete button
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
                              inputFormatters: [
                                PhoneInputFormatter(
                                  allowEndlessPhone: false,
                                )
                              ],
                              decoration: const InputDecoration(
                                  hintText: '253-561-3187',
                                  hintStyle: inputHintTextStyle,
                                  filled: true,
                                  fillColor: kcInputBackgroundColor,
                                  enabledBorder: inputBorderStyle,
                                  focusedBorder: inputBorderStyle),
                            ),
                            verticalSpaceMedium,
                            const Text(
                              'By continuing below, you agree to Dineseater sharing your party size, name and mobile number with the restaurant.',
                              textAlign: TextAlign.center,
                              style: tinyText,
                            ),
                            const SizedBox(height: 90.0),
                          ],
                        ),
                        //TODO: set button max width instead of percentage
                        FractionallySizedBox(
                          widthFactor: 1.0,
                          child: ElevatedButton(
                              onPressed: () => print('hi'),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: kcPrimaryColor,
                                  minimumSize: const Size(200, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
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
  MobileInputViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MobileInputViewModel();
}
