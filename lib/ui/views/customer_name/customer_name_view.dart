import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
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
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leadingWidth: 90,
            toolbarHeight: 40,
            leading: TextButton(
              onPressed: () => viewModel.navigateBack(),
              child: const Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new,
                    color: kcPrimaryColor,
                    size: 20,
                  ),
                  Text(
                    'Back',
                    style: backButtonStyle,
                  ),
                ],
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
                                        filled: true,
                                        fillColor: kcInputBackgroundColor,
                                        enabledBorder: inputBorderStyle,
                                        focusedBorder: inputBorderStyle),
                                  ),
                                ),
                                verticalSpaceMedium,
                                const FractionallySizedBox(
                                  widthFactor: 0.9,
                                  child: Text(
                                    'Your name will be displayed on the waiting list.',
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
                                    if (viewModel.nameFormKey.currentState!
                                        .validate()) {
                                      viewModel.navigateToMobileInputView();
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
