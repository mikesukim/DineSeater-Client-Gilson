import 'package:flutter/material.dart';
import 'package:dineseater_client_gilson/ui/common/app_colors.dart';
import 'package:dineseater_client_gilson/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import 'confirm_alert_dialog_model.dart';

class ConfirmAlertDialog extends StackedView<ConfirmAlertDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const ConfirmAlertDialog({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ConfirmAlertDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              request.title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            verticalSpaceMedium,
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => completer(DialogResponse(
                      confirmed: false,
                    )),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: kcPrimaryColor, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: kcPrimaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                horizontalSpaceMedium,
                Expanded(
                  child: GestureDetector(
                    onTap: () => completer(DialogResponse(
                      confirmed: true,
                    )),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kcPrimaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        'Ok',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  ConfirmAlertDialogModel viewModelBuilder(BuildContext context) =>
      ConfirmAlertDialogModel();
}
