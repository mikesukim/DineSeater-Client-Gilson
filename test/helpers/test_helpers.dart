import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dineseater_client_gilson/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:dineseater_client_gilson/services/cognito_service.dart';
import 'package:dineseater_client_gilson/services/dineseater_api_service.dart';
import 'package:dineseater_client_gilson/services/waiting_storage_service.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<CognitoService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<DineseaterApiService>(onMissingStub: OnMissingStub.returnDefault),
  MockSpec<WaitingStorageService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
])
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterCognitoService();
  getAndRegisterDineseaterApiService();
  getAndRegisterWaitingStorageService();
// @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(service.showCustomSheet<T, T>(
    enableDrag: anyNamed('enableDrag'),
    enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
    exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
    ignoreSafeArea: anyNamed('ignoreSafeArea'),
    isScrollControlled: anyNamed('isScrollControlled'),
    barrierDismissible: anyNamed('barrierDismissible'),
    additionalButtonTitle: anyNamed('additionalButtonTitle'),
    variant: anyNamed('variant'),
    title: anyNamed('title'),
    hasImage: anyNamed('hasImage'),
    imageUrl: anyNamed('imageUrl'),
    showIconInMainButton: anyNamed('showIconInMainButton'),
    mainButtonTitle: anyNamed('mainButtonTitle'),
    showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
    secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
    showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
    takesInput: anyNamed('takesInput'),
    barrierColor: anyNamed('barrierColor'),
    barrierLabel: anyNamed('barrierLabel'),
    customData: anyNamed('customData'),
    data: anyNamed('data'),
    description: anyNamed('description'),
  )).thenAnswer((realInvocation) =>
      Future.value(showCustomSheetResponse ?? SheetResponse<T>()));

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

MockCognitoService getAndRegisterCognitoService() {
  _removeRegistrationIfExists<CognitoService>();
  final service = MockCognitoService();
  locator.registerSingleton<CognitoService>(service);
  return service;
}

MockDineseaterApiService getAndRegisterDineseaterApiService() {
  _removeRegistrationIfExists<DineseaterApiService>();
  final service = MockDineseaterApiService();
  locator.registerSingleton<DineseaterApiService>(service);
  return service;
}

MockWaitingStorageService getAndRegisterWaitingStorageService() {
  _removeRegistrationIfExists<WaitingStorageService>();
  final service = MockWaitingStorageService();
  locator.registerSingleton<WaitingStorageService>(service);
  return service;
}
// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
