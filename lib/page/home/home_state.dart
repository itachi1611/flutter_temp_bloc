part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.loadStatus,
    this.currentIndex = 0,
  });

  final LoadStatus? loadStatus;

  final int currentIndex;

  HomeState copyWith({
    LoadStatus? loadStatus,
    int? currentIndex,
  }) {
    return HomeState(
      loadStatus: loadStatus ?? this.loadStatus,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        currentIndex,
      ];
}
