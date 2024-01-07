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
    return Stack(
      children: [
        Scaffold(
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
          body: Stack(
            alignment: Alignment.center,
            children: [
              SafeArea(
                child: Center(
                  child: Column(
                    children: [
                      Expanded(
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
                                Text(viewModel.formattedMobileNumber,
                                    style: subText),
                                TextButton(
                                    onPressed: viewModel.navigateToMealTypeView,
                                    child: const Text(
                                      'Edit my information',
                                      style: TextStyle(fontSize: 15),
                                    ))
                              ],
                            ),
                            FractionallySizedBox(
                              widthFactor: 0.9,
                              child: ElevatedButton(
                                  onPressed: viewModel.navigateToConfirm2View,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: kcPrimaryColor,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      elevation: 0),
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.0),
                                    child: Text(
                                      'Join the waitlist',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: semiBoldFontWeight),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              if (viewModel.isBusy) const CircularProgressIndicator()
            ],
          ),
        ),
        if (viewModel.isBusy)
          const ModalBarrier(
            color: Colors.black26,
            dismissible: false,
          ),
      ],
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
