import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

import '../../../model/waiting_item.dart';
import '../../common/app_colors.dart';
import '../../common/ui_helpers.dart';
import 'waiting_card_viewmodel.dart';

class WaitingCardView extends StackedView<WaitingCardViewModel> {
  final int index;
  final bool isArchive;
  final WaitingItem waitingItem;
  final Function toggleIsLoadingFromParent;

  const WaitingCardView(this.index, this.waitingItem,
      {Key? key,
      this.isArchive = false,
      required this.toggleIsLoadingFromParent})
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
            onTap: () => viewModel.showWaitingInfoDialog(waitingItem),
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
                              waitingItem.detailAttribute.isGrill
                                  ? grillIconMedium
                                  : mealIconMedium,
                              if (viewModel.isTableReady)
                                StreamBuilder<int>(
                                  stream: viewModel.stopWatchTimer.rawTime,
                                  initialData:
                                      viewModel.stopWatchTimer.rawTime.value,
                                  builder: (context, snap) {
                                    final value = snap.data!;
                                    final displayTime =
                                        StopWatchTimer.getDisplayTime(value,
                                            hours: false, milliSecond: false);
                                    return Column(
                                      children: <Widget>[
                                        Text(
                                          displayTime,
                                        ),
                                      ],
                                    );
                                  },
                                ),
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
                              waitingItem.name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'Party size: ${waitingItem.numberOfCustomers.toString()}',
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
                                onPressed: () {
                                  try {
                                    viewModel.showConfirmDialog(waitingItem);
                                  } catch (e) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ErrorAlertDialog(e: e);
                                      },
                                    );
                                  }
                                },
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
                                  onPressed: () {
                                    try {
                                      viewModel.onTapCancel(waitingItem);
                                    } catch (e) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ErrorAlertDialog(e: e);
                                        },
                                      );
                                    }
                                  }),
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
                                  onPressed: () {
                                    try {
                                      viewModel.onTapConfirm(waitingItem);
                                    } catch (e) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ErrorAlertDialog(e: e);
                                        },
                                      );
                                    }
                                  }),
                            )),
                      if (isArchive)
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  try {
                                    viewModel.showConfirmDialog(waitingItem,
                                        isArchiveView: true);
                                  } catch (e) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return ErrorAlertDialog(e: e);
                                      },
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10), // <-- Radius
                                    ),
                                    backgroundColor: kcMediumGrey),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.0),
                                  child: Text(
                                    'Return to list',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
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
      WaitingCardViewModel(waitingItem, toggleIsLoadingFromParent);
}

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog({
    super.key,
    required this.e,
  });

  final Object e;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Exception Caught'),
      content: Text('An exception occurred: $e'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
