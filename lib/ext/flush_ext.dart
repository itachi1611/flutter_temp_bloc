import 'package:flutter/material.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/generated/l10n.dart';

import '../common/app_colors.dart';

extension FlushBarExtension on FlushType {
  Color get flushBg {
    switch(this) {
      case FlushType.notification:
        return AppColors.notificationBg;
      case FlushType.success:
        return AppColors.successBg;
      case FlushType.warning:
        return AppColors.warningBg;
      case FlushType.error:
        return AppColors.errorBg;
      default:
        return AppColors.warningBg;
    }
  }

  Icon get flushIcon {
    switch(this) {
      case FlushType.notification:
        return const Icon(Icons.info, color: Colors.white);
      case FlushType.success:
        return const Icon(Icons.check_circle, color: Colors.white);
      case FlushType.warning:
        return const Icon(Icons.warning, color: Colors.white);
      case FlushType.error:
        return const Icon(Icons.error, color: Colors.white);
      default:
        return const Icon(Icons.warning, color: Colors.white);
    }
  }

  String get flushTitle {
    switch(this) {
      case FlushType.notification:
        return S.current.flush_bar_notification;
      case FlushType.success:
        return S.current.flush_bar_success;
      case FlushType.warning:
        return S.current.flush_bar_warning;
      case FlushType.error:
        return S.current.flush_bar_error;
      default:
        return S.current.flush_bar_warning;
    }
  }
}