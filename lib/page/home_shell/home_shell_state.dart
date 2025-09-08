part of 'home_shell_cubit.dart';

final class HomeShellState extends Equatable {
  final int shellIndex;

  const HomeShellState({
    this.shellIndex = 0,
  });

  HomeShellState copyWith({int? shellIndex}) {
    return HomeShellState(shellIndex: shellIndex ?? this.shellIndex);
  }

  @override
  List<Object?> get props => [
    shellIndex,
  ];
}
