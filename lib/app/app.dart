import 'package:dineseater_client_gilson/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:dineseater_client_gilson/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:dineseater_client_gilson/ui/views/home/home_view.dart';
import 'package:dineseater_client_gilson/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:dineseater_client_gilson/services/cognito_service.dart';
import 'package:dineseater_client_gilson/ui/views/mobile_input/mobile_input_view.dart';
import 'package:dineseater_client_gilson/ui/bottom_sheets/num_keypad/num_keypad_sheet.dart';
import 'package:dineseater_client_gilson/ui/views/meal_type/meal_type_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: MobileInputView),
    MaterialRoute(page: MealTypeView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: CognitoService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: NumKeypadSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
