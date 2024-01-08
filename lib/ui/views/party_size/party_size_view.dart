import 'package:dineseater_client_gilson/model/waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
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
                      key: viewModel.partySizeFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              gilsonIconSmall,
                              verticalSpaceMedium,
                              const Text(
                                'How many people in your party?',
                                style: mainText,
                              ),
                              verticalSpaceTiny,
                              const FractionallySizedBox(
                                widthFactor: 0.8,
                                child: Text(
                                  'For parties larger than 7, please speak with our restaurant staff.',
                                  style: subText,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              verticalSpaceMedium,
                              FractionallySizedBox(
                                widthFactor: 0.9,
                                child: TextFormField(
                                  autofocus: true,
                                  controller: viewModel.partySizeController,
                                  keyboardType: TextInputType.number,
                                  validator: (String? value) {
                                    String pattern = r'^([1-9][0-9]{0,1})$';
                                    RegExp regExp = RegExp(pattern);
                                    if (value!.isEmpty) {
                                      return 'Please enter a number of party size.';
                                    } else if (!regExp.hasMatch(value)) {
                                      return 'Please enter valid number of party size.';
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                      hintText: '1',
                                      hintStyle: inputHintTextStyle,
                                      enabledBorder: inputBorderStyle,
                                      focusedBorder: inputBorderStyle),
                                ),
                              ),
                            ],
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.9,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (viewModel.partySizeFormKey.currentState!
                                      .validate()) {
                                    viewModel.navigateToCustomerNameView();
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
  PartySizeViewModel viewModelBuilder(
    BuildContext context,
  ) {
    Waiting waiting = ModalRoute.of(context)?.settings.arguments as Waiting;

    return PartySizeViewModel(waiting: waiting);
  }
}
