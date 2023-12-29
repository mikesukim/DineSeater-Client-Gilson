import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'confirm_2_viewmodel.dart';

class Confirm2View extends StackedView<Confirm2ViewModel> {
  const Confirm2View({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    Confirm2ViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: null,
                  child: Text(
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
                      gilsonIconSmall,
                      Column(
                        children: [
                          Image.asset(
                            'assets/confirm2.png',
                            scale: 2.5,
                          ),
                          verticalSpaceLarge,
                          const Text('You\'re on the list!',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          const Text('We\'ll text you once ready!',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      FractionallySizedBox(
                        widthFactor: 1.0,
                        child: ElevatedButton(
                            onPressed: viewModel.navigateToHome,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kcPrimaryColor,
                                minimumSize: const Size(200, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25)),
                                elevation: 0),
                            child: const Text(
                              'Go to Home',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: semiBoldFontWeight),
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
    );
  }

  @override
  Confirm2ViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      Confirm2ViewModel();
}
