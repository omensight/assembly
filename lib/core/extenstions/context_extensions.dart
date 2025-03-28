import 'package:flutter/material.dart';

extension CoreContextExtension on BuildContext {
  bool isLargeWidthScreen() => MediaQuery.sizeOf(this).width > 600;
}
