import 'package:dineseater_client_gilson/model/waiting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'waiting_card_viewmodel.dart';

class WaitingCardView extends StackedView<WaitingCardViewModel> {
  final int index;
  final bool isArchive;
  final Waiting waiting;

  const WaitingCardView(this.index, this.waiting,
      {Key? key, this.isArchive = false})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    WaitingCardViewModel viewModel,
    Widget? child,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: SizedBox(
        height: 130,
        child: Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  color: viewModel.isTimerEnd ? Colors.red : Colors.transparent,
                  width: 10),
              borderRadius: BorderRadius.circular(15)),
          child: InkWell(
            // onTap: () => viewModel.onTapCard(index),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              waiting.isGrill!
                                  ? grillIconMedium
                                  : mealIconMedium,
                              if (viewModel.isTableReady)
                                TimerCountdown(
                                  endTime: DateTime.now()
                                      .add(const Duration(seconds: 10
                                          //       minutes: 5
                                          )),
                                  format: CountDownTimerFormat.minutesSeconds,
                                  enableDescriptions: false,
                                  spacerWidth: 2,
                                  onEnd: () => viewModel.onTimerEnd(index),
                                )
                            ],
                          ),
                        ),
                      ),
                      horizontalSpaceSmall,
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              waiting.name!,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Party size: ${waiting.partySize.toString()}',
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                      if (!isArchive && !viewModel.isTableReady)
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ElevatedButton(
                                onPressed: () =>
                                    viewModel.onTapTableReady(index),
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // <-- Radius
                                    ),
                                    backgroundColor: kcPrimaryColor),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: Text(
                                    'Table Ready',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            )),
                      if (!isArchive && viewModel.isTableReady)
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: employeeModeCancel,
                                iconSize: 60,
                                onPressed: () => viewModel.onTapCancel(index),
                              ),
                            )),
                      if (!isArchive && viewModel.isTableReady)
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                icon: employeeModeConfirm,
                                iconSize: 60,
                                onPressed: () => viewModel.onTapConfirm(index),
                              ),
                            )),
                      if (isArchive)
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () =>
                                        viewModel.onTapBackToList(),
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10), // <-- Radius
                                        ),
                                        backgroundColor: kcMediumGrey),
                                    child: const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 16.0),
                                      child: Text(
                                        'Back to list',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () =>
                                          viewModel.onTapEditCard(),
                                      child: const Text(
                                        'Edit card',
                                        style: TextStyle(color: kcMediumGrey),
                                      ))
                                ],
                              ),
                            )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  WaitingCardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      WaitingCardViewModel();
}
