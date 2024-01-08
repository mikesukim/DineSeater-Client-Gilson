import 'package:dineseater_client_gilson/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:dineseater_client_gilson/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:dineseater_client_gilson/ui/views/home/home_view.dart';
import 'package:dineseater_client_gilson/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:dineseater_client_gilson/services/cognito_service.dart';
import 'package:dineseater_client_gilson/ui/views/mobile_input/mobile_input_view.dart';
import 'package:dineseater_client_gilson/services/dineseater_api_service.dart';
import 'package:dineseater_client_gilson/ui/bottom_sheets/num_keypad/num_keypad_sheet.dart';
import 'package:dineseater_client_gilson/ui/views/meal_type/meal_type_view.dart';
import 'package:dineseater_client_gilson/ui/views/party_size/party_size_view.dart';
import 'package:dineseater_client_gilson/ui/views/customer_name/customer_name_view.dart';
import 'package:dineseater_client_gilson/ui/views/confirm_1/confirm_1_view.dart';
import 'package:dineseater_client_gilson/ui/views/confirm_2/confirm_2_view.dart';
import 'package:dineseater_client_gilson/ui/views/employee_mode/employee_mode_view.dart';
import 'package:dineseater_client_gilson/ui/views/employee_mode_archive/employee_mode_archive_view.dart';
import 'package:dineseater_client_gilson/services/waiting_storage_service.dart';
import 'package:dineseater_client_gilson/ui/views/waiting_card/waiting_card_view.dart';
import 'package:dineseater_client_gilson/ui/dialogs/waiting_info/waiting_info_dialog.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: MobileInputView),
    MaterialRoute(page: MealTypeView),
    MaterialRoute(page: PartySizeView),
    MaterialRoute(page: CustomerNameView),
    MaterialRoute(page: Confirm1View),
    MaterialRoute(page: Confirm2View),
    MaterialRoute(page: EmployeeModeView),
    MaterialRoute(page: EmployeeModeArchiveView),
    MaterialRoute(page: WaitingCardView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: CognitoService),
    LazySingleton(classType: DineseaterApiService),
    LazySingleton(classType: WaitingStorageService),
// @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    StackedBottomsheet(classType: NumKeypadSheet),
// @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    StackedDialog(classType: WaitingInfoDialog),
// @stacked-dialog
  ],
)
class App {}
