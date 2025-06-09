import 'package:flutter/material.dart';

extension ColumnExtensions on Column {
  Widget withColumn(
    spacing,
    mainAxisAlignment,
    crossAxisAlignment,
  ) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
        spacing: spacing,
        children: children);
  }
}

extension StringOperation on String {
  String toGetFirstString() {
    return this[0].toUpperCase();
  }
}
