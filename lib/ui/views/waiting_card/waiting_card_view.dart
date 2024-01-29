import 'package:dineseater_client_gilson/model/waiting_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
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
  final Function setErrorFromParent;

  const WaitingCardView(this.index, this.waitingItem,
      {Key? key,
      this.isArchive = false,
      required this.toggleIsLoadingFromParent,
      required this.setErrorFromParent})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    WaitingCardViewModel viewModel,
    Widget? child,
  ) {
    return Card(
      color: waitingItem.status ==
                  WaitingStatus.CANCELLED.name.toLowerCase() ||
              waitingItem.status == WaitingStatus.MISSED.name.toLowerCase()
          ? kcNotHereCardColor
          : waitingItem.status == WaitingStatus.ARRIVED.name.toLowerCase()
              ? kcHereCardColor
              : waitingItem.status ==
                          WaitingStatus.TEXT_SENT.name.toLowerCase() &&
                      viewModel.isTimerEnd
                  ? kcInactiveCardColor
                  : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            if (waitingItem.status ==
                    WaitingStatus.TEXT_SENT.name.toLowerCase() ||
                waitingItem.status ==
                    WaitingStatus.WAITING.name.toLowerCase())
              Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      try {
                        viewModel.showConfirmDialog(waitingItem,
                            isCancel: true);
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return ErrorAlertDialog(e: e);
                          },
                        );
                      }
                    },
                    icon: employeeModeCancel,
                    iconSize: 20,
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  )),
            Column(
              children: [
                if (waitingItem.status ==
                        WaitingStatus.TEXT_SENT.name.toLowerCase() ||
                    waitingItem.status ==
                        WaitingStatus.WAITING.name.toLowerCase())
                  verticalSpaceSmall,
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 2.0),
                            child: Text(
                              waitingItem.numberOfCustomers.toString(),
                              style: TextStyle(
                                  fontSize: 78,
                                  fontWeight: FontWeight.w500,
                                  color: waitingItem.status !=
                                              WaitingStatus.TEXT_SENT.name
                                                  .toLowerCase() &&
                                          waitingItem.status !=
                                              WaitingStatus.WAITING.name
                                                  .toLowerCase()
                                      ? kcMediumGrey
                                      : kcPrimaryColor),
                            ),
                          ),
                          waitingItem.detailAttribute.isGrill
                              ? RotatedBox(
                                  quarterTurns: 1, child: grillIconMedium)
                              : mealIconMedium
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 2.0),
                              child: Text(
                                waitingItem.name,
                                style: mainText,
                              ),
                            ),
                            Text(
                              'Phone: ${viewModel.formattedPhoneNumber}',
                              style: tinyText,
                            ),
                            Text(
                              'Created time: ${viewModel.dateCreated}',
                              style: tinyText,
                            ),
                            Text(
                              'Modified time: ${viewModel.lastModified}',
                              style: tinyText,
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                if (Device.get().isTablet)
                  verticalSpaceTiny,
                Row(
                  children: [
                    if (!isArchive && !viewModel.isTextSent)
                      Expanded(
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
                              elevation: 0,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10), // <-- Radius
                              ),
                              backgroundColor: kcPrimaryColor),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Send text',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: semiBoldFontWeight),
                            ),
                          ),
                        ),
                      ),
                    if (!isArchive && viewModel.isTextSent)
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          try {
                            viewModel.onTapMiss(waitingItem);
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
                              borderRadius:
                                  BorderRadius.circular(10), // <-- Radius
                            ),
                            backgroundColor: viewModel.isTimerEnd
                                ? kcInactiveCardButtonColor
                                : kcToggleButtonColor),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Not here',
                            style: TextStyle(
                                fontSize: 16,
                                color: kcVeryLightGrey,
                                fontWeight: semiBoldFontWeight),
                          ),
                        ),
                      )),
                    if (!isArchive && viewModel.isTextSent)
                      horizontalSpaceSmall,
                    if (!isArchive && viewModel.isTextSent)
                      Expanded(
                          child: ElevatedButton(
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
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // <-- Radius
                            ),
                            backgroundColor: kcPrimaryColor),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Here',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: semiBoldFontWeight),
                              ),
                              horizontalSpaceTiny,
                              if (viewModel.isTextSent)
                                StreamBuilder<int>(
                                  stream: viewModel.stopWatchTimer.rawTime,
                                  initialData:
                                      viewModel.stopWatchTimer.rawTime.value,
                                  builder: (context, snap) {
                                    final value = snap.data!;
                                    final displayTime =
                                        StopWatchTimer.getDisplayTime(value,
                                            hours: false, milliSecond: false);
                                    return Text(
                                      '($displayTime)',
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),
                      )),
                    if (isArchive)
                      Expanded(
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
                              borderRadius:
                                  BorderRadius.circular(10), // <-- Radius
                            ),
                            backgroundColor: kcVeryLightGrey),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Text(
                            'Back to list',
                            style: TextStyle(
                                fontSize: 16, fontWeight: semiBoldFontWeight),
                          ),
                        ),
                      )),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  WaitingCardViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      WaitingCardViewModel(waitingItem, toggleIsLoadingFromParent, setErrorFromParent);
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
