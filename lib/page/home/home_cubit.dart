import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_temp/common/app_enums.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  Future<void> initData() async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    emit(state.copyWith(loadStatus: LoadStatus.success));
  }

  void onChangedIndex(int position) => emit(state.copyWith(currentIndex: position));
}
