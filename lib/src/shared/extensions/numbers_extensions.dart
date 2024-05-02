import 'package:intl/intl.dart';

extension NumExtensions on num {
  /// Returns a [String] representation of this [number] with a compact format.
  ///
  /// ```dart
  /// 100.compact() // 100
  /// 1000.compact() // 1k
  /// 1025000.compact() // 1.03M
  /// ```

  String compact() => NumberFormat.compact().format(this);
}
