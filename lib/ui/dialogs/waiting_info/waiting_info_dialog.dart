import 'package:dineseater_client_gilson/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:dineseater_client_gilson/ui/common/ui_helpers.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../model/waiting_item.dart';
import 'waiting_info_dialog_model.dart';

class WaitingInfoDialog extends StackedView<WaitingInfoDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const WaitingInfoDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    WaitingInfoDialogModel viewModel,
    Widget? child,
  ) {
    WaitingItem waiting = request.data;
    String formattedPhoneNumber = viewModel.formatPhoneNumber(waiting.phoneNumber);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              waiting.name,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: semiBoldFontWeight,
              ),
            ),
            verticalSpaceSmall,
            waiting.detailAttribute.isGrill ? grillIconMedium : mealIconMedium,
            verticalSpaceSmall,
            Text(
              'Party size: ${waiting.numberOfCustomers.toString()}',
              style: subText,
            ),
            verticalSpaceTiny,
            Text(
              'Phone: $formattedPhoneNumber',
              style: subText,
            ),
            verticalSpaceTiny,
            Text(
              'Created Time: ${DateFormat("HH:mm:ss").format(DateTime.parse(waiting.dateCreated))}',
              style: subText,
            ),
            verticalSpaceTiny,
            Text(
              'Last Modified Time: ${DateFormat("HH:mm:ss").format(DateTime.parse(waiting.lastModified))}',
              style: subText,
            ),
            verticalSpaceMedium,
            GestureDetector(
              onTap: () => completer(DialogResponse(confirmed: true)),
              child: Container(
                height: 50,
                width: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kcPrimaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  WaitingInfoDialogModel viewModelBuilder(BuildContext context) =>
      WaitingInfoDialogModel();
}
