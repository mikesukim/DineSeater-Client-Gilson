import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:dineseater_client_gilson/app/app.bottomsheets.dart';
import 'package:dineseater_client_gilson/app/app.locator.dart';
import 'package:dineseater_client_gilson/ui/common/app_strings.dart';
import 'package:dineseater_client_gilson/ui/views/home/home_viewmodel.dart';

import '../helpers/test_helpers.dart';

void main() {
  HomeViewModel getModel() => HomeViewModel();

  group('HomeViewmodelTest -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
