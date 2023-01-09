import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_temp/common/app_enums.dart';

import '../../common/app_constants.dart';
import '../../database/app_shared_preference.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void checkFirstRunNavigate() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    var isFirstRun = await AppSharedPreference.getSharedPrefConfig(AppConstants.firstRun);
    isFirstRun ??= true;
    emit(state.copyWith(loadStatus: LoadStatus.success, navigationType: isFirstRun ? FirstRunNavigationType.firstRun : FirstRunNavigationType.notFirstRun));
  }
}
