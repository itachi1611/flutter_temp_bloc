import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

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
}
