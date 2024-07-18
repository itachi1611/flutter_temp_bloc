import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'app_state.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit() : super(const AppState());

  void setConnectionStatus(ConnectivityResult connectivityResult) => emit(state.copyWith(connectivityResult: connectivityResult));

  void onChangeSwitch(bool val) {
    emit(state.copyWith(themeMode: val ? ThemeMode.light : ThemeMode.dark));
  }

  void setLocale(String? val) {
    switch(val) {
      case 'Eng':
        emit(state.copyWith(locale: const Locale('en')));
        break;
      case 'Vie':
        emit(state.copyWith(locale: const Locale('vi')));
        break;
      case 'Jap':
        emit(state.copyWith(locale: const Locale('ja')));
        break;
      default:
        emit(state.copyWith(locale: const Locale('en')));
        break;
    }
  }

  void setListLang() => emit(state.copyWith(lists: ['Eng', 'Vie', 'Jap']));

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    var mode = json['themeMode'];
    if(mode != null) {
      switch(mode) {
        case 'ThemeMode.dark':
          return const AppState(themeMode: ThemeMode.dark);
        case 'ThemeMode.light':
          return const AppState(themeMode: ThemeMode.light);
        case 'ThemeMode.system':
        default:
          return const AppState(themeMode: ThemeMode.system);
      }
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return <String, String>{'themeMode': state.themeMode.toString()};
  }
}
