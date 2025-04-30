import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

const Color kSeedColor = Colors.blue;
const double kStandardPadding = 16.0;
const double kStandardMinimalPadding = 4.0;
const double kStandardInnerPadding = 8.0;
const double kStandardDialogPadding = 24.0;
const double kStandardSpacing = 8.0;
const double kStandardMediumSpacing = 8.0;
const double kStandardBorderRadius = 16.0;
const double kStandardListItemHeight = 48.0;
const double kStandardListItemPadding = 8.0;
const double kWideScreenBreakPoint = 600;
const double kMinItemHeight = 36;
const String appName = String.fromEnvironment(
  'APP_NAME',
  defaultValue: 'ClinicAut',
);
final DateFormat kStandardDateFormat = DateFormat('dd/MM/yyyy');
final DateFormat kStandardDateAndTimeFormat = DateFormat('dd/MM/yyyy - HH:mm');
final TimeOfDayFormat kStandardTimeOfDayFormat = TimeOfDayFormat.HH_colon_mm;
final DateTime kInitialCalendarDate = DateTime(2024);

String formatTimeOfDay(TimeOfDay time) {
  final hours = time.hourOfPeriod;
  final minutes = time.minute.toString().padLeft(2, '0');
  final period = time.period == DayPeriod.am ? 'AM' : 'PM';
  return '$hours:$minutes $period';
}

bool kIsSmallWidth(BuildContext context) {
  var width = MediaQuery.sizeOf(context).width;
  return width < 600;
}
