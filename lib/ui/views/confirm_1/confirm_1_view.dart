import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../model/waiting.dart';
import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'confirm_1_viewmodel.dart';

class Confirm1View extends StackedView<Confirm1ViewModel> {
  const Confirm1View({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    Confirm1ViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
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
                      gilsonIconSmall,
                      Column(
                        children: [
                          Image.asset(
                            'assets/confirm1.png',
                            scale: 2.5,
                          ),
                          verticalSpaceLarge,
                          Text(
                              '${viewModel.waiting.name}, party of ${viewModel.waiting.partySize}',
                              style: mainText),
                          verticalSpaceTiny,
                          Text(viewModel.formattedMobileNumber, style: subText),
                          TextButton(
                              onPressed: viewModel.navigateToMealTypeView,
                              child: const Text(
                                'Edit my information',
                                style: TextStyle(fontSize: 15),
                              ))
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
                                onPressed: viewModel.navigateToConfirm2View,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kcPrimaryColor,
                                    minimumSize: const Size(200, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    elevation: 0),
                                child: const Text(
                                  'Join the waitlist',
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
    );
  }

  @override
  Confirm1ViewModel viewModelBuilder(
    BuildContext context,
  ) {
    Waiting waiting = ModalRoute.of(context)?.settings.arguments as Waiting;

    return Confirm1ViewModel(waiting: waiting);
  }
}
