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
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: Form(
                    key: viewModel.nameFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            gilsonIconSmall,
                            verticalSpaceMedium,
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
                            FractionallySizedBox(
                              widthFactor: 0.9,
                              child: TextFormField(
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
                            ),
                          ],
                        ),
                        FractionallySizedBox(
                          widthFactor: 0.9,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (viewModel.nameFormKey.currentState!
                                      .validate()) {
                                    viewModel.navigateToMobileInputView();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kcPrimaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25)),
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
  CustomerNameViewModel viewModelBuilder(
    BuildContext context,
  ) {
    Waiting waiting = ModalRoute.of(context)?.settings.arguments as Waiting;

    return CustomerNameViewModel(waiting: waiting);
  }
}
