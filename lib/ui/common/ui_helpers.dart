import 'dart:math';

import 'package:flutter/material.dart';

import 'app_colors.dart';

const double _tinySize = 5.0;
const double _smallSize = 10.0;
const double _mediumSize = 25.0;
const double _largeSize = 40.0;
const double _extraLargeSize = 50.0;
const double _massiveSize = 120.0;

const Widget horizontalSpaceTiny = SizedBox(width: _tinySize);
const Widget horizontalSpaceSmall = SizedBox(width: _smallSize);
const Widget horizontalSpaceMedium = SizedBox(width: _mediumSize);
const Widget horizontalSpaceLarge = SizedBox(width: _largeSize);
const Widget horizontalSpaceExtraLarge = SizedBox(width: _extraLargeSize);

const Widget verticalSpaceTiny = SizedBox(height: _tinySize);
const Widget verticalSpaceSmall = SizedBox(height: _smallSize);
const Widget verticalSpaceMedium = SizedBox(height: _mediumSize);
const Widget verticalSpaceLarge = SizedBox(height: _largeSize);
const Widget verticalSpaceExtraLarge = SizedBox(height: _extraLargeSize);
const Widget verticalSpaceMassive = SizedBox(height: _massiveSize);

const FontWeight mediumFontWeight = FontWeight.w500;
const FontWeight semiBoldFontWeight = FontWeight.w600;

Widget gilsonIconSmall = Image.asset(
  'assets/Logo_Gilson.png',
  scale: 3.0,
);
Widget mealIconSmall = Image.asset(
  'assets/meal.png',
  scale: 2.6,
);
Widget grillIconSmall = Image.asset(
  'assets/grill.png',
  scale: 3.0,
);
Widget mealIconMedium = Image.asset(
  'assets/meal.png',
  scale: 1.4,
);
Widget grillIconMedium = Image.asset(
  'assets/grill.png',
  scale: 1.4,
);
Widget employeeModeCancel = Image.asset(
  'assets/employee_mode_cancel.png',
);
Widget employeeModeConfirm = Image.asset(
  'assets/employee_mode_confirm.png',
);

const TextStyle mainText =
    TextStyle(fontSize: 20, fontWeight: semiBoldFontWeight);
const TextStyle subText = TextStyle(fontSize: 15, color: kcVeryLightGrey);
const TextStyle tinyText = TextStyle(
    fontSize: 13, color: kcVeryLightGrey, fontWeight: FontWeight.w300);
const TextStyle inputHintTextStyle =
    TextStyle(color: kcInputHintTextColor, fontWeight: mediumFontWeight);
const TextStyle defaultPolicyTextStyle =
    TextStyle(color: kcVeryLightGrey, fontSize: 13.0);
const TextStyle hyperLinkStyle = TextStyle(color: Colors.blue, fontSize: 13.0);

const backButtonStyle = TextStyle(color: kcPrimaryColor, fontSize: 16);
const backButtonTabletStyle = TextStyle(color: kcPrimaryColor, fontSize: 20);
const blackBackButtonStyle = TextStyle(color: Colors.black, fontSize: 16);
const blackBackButtonTabletStyle = TextStyle(color: Colors.black, fontSize: 20);

const inputBorderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: kcInputBorderColor));

Widget spacedDivider = const Column(
  children: <Widget>[
    verticalSpaceMedium,
    Divider(color: Colors.blueGrey, height: 5.0),
    verticalSpaceMedium,
  ],
);

Widget verticalSpace(double height) => SizedBox(height: height);

double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

double screenHeightFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
    min((screenHeight(context) - offsetBy) / dividedBy, max);

double screenWidthFraction(BuildContext context,
        {int dividedBy = 1, double offsetBy = 0, double max = 3000}) =>
    min((screenWidth(context) - offsetBy) / dividedBy, max);

double halfScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 2);

double thirdScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 3);

double quarterScreenWidth(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 4);

double getResponsiveHorizontalSpaceMedium(BuildContext context) =>
    screenWidthFraction(context, dividedBy: 10);

double getResponsiveSmallFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 14, max: 15);

double getResponsiveMediumFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 16, max: 17);

double getResponsiveLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 21, max: 31);

double getResponsiveExtraLargeFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 25);

double getResponsiveMassiveFontSize(BuildContext context) =>
    getResponsiveFontSize(context, fontSize: 30);

double getResponsiveFontSize(BuildContext context,
    {double? fontSize, double? max}) {
  max ??= 100;

  var responsiveSize = min(
      screenWidthFraction(context, dividedBy: 10) * ((fontSize ?? 100) / 100),
      max);

  return responsiveSize;
}
