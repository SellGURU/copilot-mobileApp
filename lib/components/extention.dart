/// This file defines two custom extensions to enhance the usability of certain Flutter widgets
/// and provide additional utility functions for developers.

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

/// Extension on `double` type to simplify the creation of `SizedBox` widgets.
extension SizedBoxExtention on double {
  /// Creates a `SizedBox` with the current double value as the height.
  SizedBox get height => SizedBox(
    height: toDouble(),
  );

  /// Creates a `SizedBox` with the current double value as the width.
  SizedBox get width => SizedBox(
    width: toDouble(),
  );
}

/// Extension on `int` type to format numbers with commas for better readability.
extension IntExtention on int {
  /// Formats the integer as a string with commas separating the thousands.
  /// Example: 1000000 becomes "1,000,000".
  String get separateWithComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}
