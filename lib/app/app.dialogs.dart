// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/confirm_alert/confirm_alert_dialog.dart';
import '../ui/dialogs/waiting_info/waiting_info_dialog.dart';

enum DialogType {
  confirmAlert,
  waitingInfo,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.confirmAlert: (context, request, completer) =>
        ConfirmAlertDialog(request: request, completer: completer),
    DialogType.waitingInfo: (context, request, completer) =>
        WaitingInfoDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
