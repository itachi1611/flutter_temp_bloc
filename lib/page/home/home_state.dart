part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.lists,
  });

  final List<String>? lists;

  HomeState copyWith({
    List<String>? lists,
  }) {
    return HomeState(
      lists: lists ?? this.lists,
    );
  }

  @override
  List<Object?> get props => [
        lists,
      ];
}
