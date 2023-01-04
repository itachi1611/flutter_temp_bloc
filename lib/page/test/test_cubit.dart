import 'package:bloc/bloc.dart';
import 'package:english_words/english_words.dart';
import 'package:equatable/equatable.dart';

import '../../common/app_enums.dart';

part 'test_state.dart';

class TestCubit extends Cubit<TestState> {
  TestCubit() : super(const TestState());

  void init() {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    var lists = <String>[];
    for(var i = 0; i < 11; i++) {
      if(i % 2 == 0) {
        lists.add(nouns.take(10).map((e) => e.split(' ')).toString());
      } else {
        lists.add(nouns.take(5).map((e) => e.split(' ')).toString());
      }
    }
    emit(state.copyWith(loadStatus: LoadStatus.success, tests: lists, isMultiOn: false, isOnlyOn: false));
  }

  void toggle() => emit(state.copyWith(isMultiOn: !state.isMultiOn!));
}
