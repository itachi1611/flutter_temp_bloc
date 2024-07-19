import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/generated/l10n.dart';

extension SnackBarExtension on SnackBarType {
  String get snackTitle {
    switch(this) {
      case SnackBarType.info:
        return S.current.snack_bar_info;
      case SnackBarType.success:
        return S.current.snack_bar_success;
      case SnackBarType.warning:
        return S.current.snack_bar_warning;
      case SnackBarType.error:
        return S.current.snack_bar_error;
      default:
        return S.current.snack_bar_warning;
    }
  }

  static SnackBarType snackBarType(AnimatedSnackBarType type) {
    switch(type) {
      case AnimatedSnackBarType.info:
        return SnackBarType.info;
      case AnimatedSnackBarType.success:
        return SnackBarType.success;
      case AnimatedSnackBarType.warning:
        return SnackBarType.warning;
      case AnimatedSnackBarType.error:
        return SnackBarType.error;
      default:
        return SnackBarType.warning;
    }
  }
}