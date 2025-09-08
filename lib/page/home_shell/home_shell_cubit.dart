import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_shell_state.dart';

class HomeShellCubit extends Cubit<HomeShellState> {
  HomeShellCubit() : super(const HomeShellState());

  void onChangeBottomNavigationBarItem(int shellIndex) => emit(state.copyWith(shellIndex: shellIndex));
}
