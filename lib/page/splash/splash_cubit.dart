import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temp/database/app_shared_preference.dart';
import 'package:flutter_temp/main.dart';
import 'package:flutter_temp/utils/app_info.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  void getDeviceInfo() {
    AppInfo.instance.getDeviceInfo();
    appLogger.i(AppSharedPreference.getDeviceInfo());
  }

  void onAnimateLogo() {
    Future.delayed(const Duration(milliseconds: 2500), () {
      emit(state.copyWith(logoStyle: FlutterLogoStyle.markOnly));
    });
  }
}
