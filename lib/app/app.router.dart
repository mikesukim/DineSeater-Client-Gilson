// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dineseater_client_gilson/model/waiting_item.dart' as _i14;
import 'package:dineseater_client_gilson/ui/views/confirm_1/confirm_1_view.dart'
    as _i8;
import 'package:dineseater_client_gilson/ui/views/confirm_2/confirm_2_view.dart'
    as _i9;
import 'package:dineseater_client_gilson/ui/views/customer_name/customer_name_view.dart'
    as _i7;
import 'package:dineseater_client_gilson/ui/views/employee_mode/employee_mode_view.dart'
    as _i10;
import 'package:dineseater_client_gilson/ui/views/employee_mode_archive/employee_mode_archive_view.dart'
    as _i11;
import 'package:dineseater_client_gilson/ui/views/home/home_view.dart' as _i2;
import 'package:dineseater_client_gilson/ui/views/meal_type/meal_type_view.dart'
    as _i5;
import 'package:dineseater_client_gilson/ui/views/mobile_input/mobile_input_view.dart'
    as _i4;
import 'package:dineseater_client_gilson/ui/views/party_size/party_size_view.dart'
    as _i6;
import 'package:dineseater_client_gilson/ui/views/startup/startup_view.dart'
    as _i3;
import 'package:dineseater_client_gilson/ui/views/waiting_card/waiting_card_view.dart'
    as _i12;
import 'package:flutter/material.dart' as _i13;
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i15;

class Routes {
  static const homeView = '/home-view';

  static const startupView = '/startup-view';

  static const mobileInputView = '/mobile-input-view';

  static const mealTypeView = '/meal-type-view';

  static const partySizeView = '/party-size-view';

  static const customerNameView = '/customer-name-view';

  static const confirm1View = '/confirm1-view';

  static const confirm2View = '/confirm2-view';

  static const employeeModeView = '/employee-mode-view';

  static const employeeModeArchiveView = '/employee-mode-archive-view';

  static const waitingCardView = '/waiting-card-view';

  static const all = <String>{
    homeView,
    startupView,
    mobileInputView,
    mealTypeView,
    partySizeView,
    customerNameView,
    confirm1View,
    confirm2View,
    employeeModeView,
    employeeModeArchiveView,
    waitingCardView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.homeView,
      page: _i2.HomeView,
    ),
    _i1.RouteDef(
      Routes.startupView,
      page: _i3.StartupView,
    ),
    _i1.RouteDef(
      Routes.mobileInputView,
      page: _i4.MobileInputView,
    ),
    _i1.RouteDef(
      Routes.mealTypeView,
      page: _i5.MealTypeView,
    ),
    _i1.RouteDef(
      Routes.partySizeView,
      page: _i6.PartySizeView,
    ),
    _i1.RouteDef(
      Routes.customerNameView,
      page: _i7.CustomerNameView,
    ),
    _i1.RouteDef(
      Routes.confirm1View,
      page: _i8.Confirm1View,
    ),
    _i1.RouteDef(
      Routes.confirm2View,
      page: _i9.Confirm2View,
    ),
    _i1.RouteDef(
      Routes.employeeModeView,
      page: _i10.EmployeeModeView,
    ),
    _i1.RouteDef(
      Routes.employeeModeArchiveView,
      page: _i11.EmployeeModeArchiveView,
    ),
    _i1.RouteDef(
      Routes.waitingCardView,
      page: _i12.WaitingCardView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.HomeView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.HomeView(),
        settings: data,
      );
    },
    _i3.StartupView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.StartupView(),
        settings: data,
      );
    },
    _i4.MobileInputView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.MobileInputView(),
        settings: data,
      );
    },
    _i5.MealTypeView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.MealTypeView(),
        settings: data,
      );
    },
    _i6.PartySizeView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.PartySizeView(),
        settings: data,
      );
    },
    _i7.CustomerNameView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.CustomerNameView(),
        settings: data,
      );
    },
    _i8.Confirm1View: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.Confirm1View(),
        settings: data,
      );
    },
    _i9.Confirm2View: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.Confirm2View(),
        settings: data,
      );
    },
    _i10.EmployeeModeView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.EmployeeModeView(),
        settings: data,
      );
    },
    _i11.EmployeeModeArchiveView: (data) {
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.EmployeeModeArchiveView(),
        settings: data,
      );
    },
    _i12.WaitingCardView: (data) {
      final args = data.getArgs<WaitingCardViewArguments>(nullOk: false);
      return _i13.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.WaitingCardView(args.index, args.waitingItem,
            key: args.key,
            isArchive: args.isArchive,
            toggleIsLoadingFromParent: args.toggleIsLoadingFromParent,
            setErrorFromParent: args.setErrorFromParent),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class WaitingCardViewArguments {
  const WaitingCardViewArguments({
    required this.index,
    required this.waitingItem,
    this.key,
    this.isArchive = false,
    required this.toggleIsLoadingFromParent,
    required this.setErrorFromParent,
  });

  final int index;

  final _i14.WaitingItem waitingItem;

  final _i13.Key? key;

  final bool isArchive;

  final Function toggleIsLoadingFromParent;

  final Function setErrorFromParent;

  @override
  String toString() {
    return '{"index": "$index", "waitingItem": "$waitingItem", "key": "$key", "isArchive": "$isArchive", "toggleIsLoadingFromParent": "$toggleIsLoadingFromParent", "setErrorFromParent": "$setErrorFromParent"}';
  }

  @override
  bool operator ==(covariant WaitingCardViewArguments other) {
    if (identical(this, other)) return true;
    return other.index == index &&
        other.waitingItem == waitingItem &&
        other.key == key &&
        other.isArchive == isArchive &&
        other.toggleIsLoadingFromParent == toggleIsLoadingFromParent &&
        other.setErrorFromParent == setErrorFromParent;
  }

  @override
  int get hashCode {
    return index.hashCode ^
        waitingItem.hashCode ^
        key.hashCode ^
        isArchive.hashCode ^
        toggleIsLoadingFromParent.hashCode ^
        setErrorFromParent.hashCode;
  }
}

extension NavigatorStateExtension on _i15.NavigationService {
  Future<dynamic> navigateToHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMobileInputView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.mobileInputView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToMealTypeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.mealTypeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToPartySizeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.partySizeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCustomerNameView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.customerNameView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToConfirm1View([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.confirm1View,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToConfirm2View([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.confirm2View,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEmployeeModeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.employeeModeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEmployeeModeArchiveView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.employeeModeArchiveView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToWaitingCardView({
    required int index,
    required _i14.WaitingItem waitingItem,
    _i13.Key? key,
    bool isArchive = false,
    required Function toggleIsLoadingFromParent,
    required Function setErrorFromParent,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.waitingCardView,
        arguments: WaitingCardViewArguments(
            index: index,
            waitingItem: waitingItem,
            key: key,
            isArchive: isArchive,
            toggleIsLoadingFromParent: toggleIsLoadingFromParent,
            setErrorFromParent: setErrorFromParent),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.homeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithStartupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.startupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMobileInputView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.mobileInputView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithMealTypeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.mealTypeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithPartySizeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.partySizeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCustomerNameView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.customerNameView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithConfirm1View([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.confirm1View,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithConfirm2View([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.confirm2View,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEmployeeModeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.employeeModeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEmployeeModeArchiveView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.employeeModeArchiveView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithWaitingCardView({
    required int index,
    required _i14.WaitingItem waitingItem,
    _i13.Key? key,
    bool isArchive = false,
    required Function toggleIsLoadingFromParent,
    required Function setErrorFromParent,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.waitingCardView,
        arguments: WaitingCardViewArguments(
            index: index,
            waitingItem: waitingItem,
            key: key,
            isArchive: isArchive,
            toggleIsLoadingFromParent: toggleIsLoadingFromParent,
            setErrorFromParent: setErrorFromParent),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}
