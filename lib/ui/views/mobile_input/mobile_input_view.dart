import 'package:dineseater_client_gilson/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_multi_formatter/formatters/phone_input_formatter.dart';
import 'package:stacked/stacked.dart';
import '../../../model/waiting.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leadingWidth: 60,
          toolbarHeight: 40,
          leading: TextButton(
            onPressed: () => viewModel.navigateBack(),
            child: const Text(
              'Back',
              style: backButtonStyle,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding:
                EdgeInsets.only(bottom: Device.get().isTablet ? 20.0 : 8.0),
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: Form(
                      key: viewModel.mobileInputFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              gilsonIconSmall,
                              verticalSpaceMedium,
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
                              FractionallySizedBox(
                                widthFactor: 0.9,
                                child: Row(
                                  children: [
                                    const Text(
                                      '+1',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    horizontalSpaceSmall,
                                    Expanded(
                                      child: TextFormField(
                                        autofocus: true,
                                        controller: viewModel.phoneController,
                                        keyboardType: TextInputType.phone,
                                        validator: (String? value) {
                                          value = value?.replaceAll('(', '');
                                          value = value?.replaceAll(')', '');
                                          value = value?.replaceAll(' ', '');
                                          String pattern =
                                              r'^(?:[+0]9)?[0-9]{10,13}$';
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
                                            defaultCountryCode: 'US'
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
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpaceMedium,
                              const FractionallySizedBox(
                                widthFactor: 0.9,
                                child: Text(
                                  'By continuing below, you agree to Dineseater sharing your party size, name and mobile number with the restaurant.',
                                  textAlign: TextAlign.center,
                                  style: tinyText,
                                ),
                              ),
                            ],
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.9,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (viewModel.mobileInputFormKey.currentState!
                                      .validate()) {
                                    viewModel.navigateToConfirm1view();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kcPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    elevation: 0),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: Text(
                                    'Next',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: semiBoldFontWeight),
                                  ),
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
      ),
    );
  }

  @override
  MobileInputViewModel viewModelBuilder(
    BuildContext context,
  ) {
    Waiting waiting = ModalRoute.of(context)?.settings.arguments as Waiting;

    return MobileInputViewModel(waiting: waiting);
  }
}
