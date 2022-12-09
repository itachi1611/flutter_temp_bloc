import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermission extends WidgetsBindingObserver {
  final Permission permission;
  final VoidCallback actionGranted;
  final VoidCallback actionDenied;

  AppPermission({
    required this.permission,
    required this.actionGranted,
    required this.actionDenied,
  }) {
    WidgetsBinding.instance.addObserver(this);
  }

  late PermissionStatus status;

  Future<PermissionStatus> get checkPermissionStatus async => await permission.status;

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  Future<void> onHandlePermissionStatus() async {
    status = await checkPermissionStatus;
    if (status.isDenied) {
      await permission.request();
      status = await checkPermissionStatus;
      if(status.isDenied || status.isRestricted || status.isLimited) {
        actionDenied.call();
      } else if(status.isPermanentlyDenied) {
        if(Platform.isIOS) {
          openAppSettings();
        } else {
          await permission.request();
        }
      } else { // status.isGranted
        actionGranted.call();
      }
    } else if (status.isGranted) {
      actionGranted.call();
    } else if (status.isDenied || status.isRestricted || status.isLimited){
      actionDenied.call();
    } else { // status.isGranted
      actionGranted.call();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      checkPermissionStatus;
    }
  }
}
