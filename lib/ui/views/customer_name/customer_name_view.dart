import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../model/waiting.dart';
import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'customer_name_viewmodel.dart';

class CustomerNameView extends StackedView<CustomerNameViewModel> {
  const CustomerNameView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CustomerNameViewModel viewModel,
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
                    child: Form(
                      key: viewModel.nameFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              gilsonIconSmall,
                              verticalSpaceSmall,
                              const Text(
                                'What\'s your name?',
                                style: mainText,
                              ),
                              verticalSpaceTiny,
                              const FractionallySizedBox(
                                widthFactor: 0.8,
                                child: Text(
                                  'Your name will help us identify you.',
                                  style: subText,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              verticalSpaceMedium,
                              TextFormField(
                                autofocus: true,
                                controller: viewModel.nameController,
                                keyboardType: TextInputType.name,
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your name.';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                    hintText: 'Michael',
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
                              // const Text(
                              //   'Estimated wait: 15-25 minutes',
                              //   style: subText,
                              // ),
                              // verticalSpaceMedium,
                              //TODO: set button max width instead of percentage
                              FractionallySizedBox(
                                widthFactor: 1.0,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (viewModel.nameFormKey.currentState!
                                          .validate()) {
                                        viewModel.navigateToMobileInputView();
                                      }
                                    },
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
  CustomerNameViewModel viewModelBuilder(
    BuildContext context,
  ) {
    Waiting waiting = ModalRoute.of(context)?.settings.arguments as Waiting;

    return CustomerNameViewModel(waiting: waiting);
  }
}
