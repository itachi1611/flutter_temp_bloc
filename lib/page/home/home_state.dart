part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.loadStatus,
  });

  final LoadStatus? loadStatus;

  HomeState copyWith({
    LoadStatus? loadStatus,
  }) {
    return HomeState(
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
      ];
}
