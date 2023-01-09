part of 'main_cubit.dart';

class MainState extends Equatable {
  const MainState({
    this.loadStatus,
    this.navigationType,
  });

  final LoadStatus? loadStatus;

  final FirstRunNavigationType? navigationType;

  MainState copyWith({
    LoadStatus? loadStatus,
    FirstRunNavigationType? navigationType,
  }) {
    return MainState(
      loadStatus: loadStatus ?? this.loadStatus,
      navigationType: navigationType ?? this.navigationType,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        navigationType,
      ];
}
