part of 'test_cubit.dart';

class TestState extends Equatable {
  const TestState({
    this.loadStatus,
    this.tests,
    this.isMultiOn,
    this.isOnlyOn,
  });

  final LoadStatus? loadStatus;
  final List<String>? tests;
  final bool? isMultiOn;
  final bool? isOnlyOn;

  TestState copyWith({
    LoadStatus? loadStatus,
    List<String>? tests,
    bool? isMultiOn,
    bool? isOnlyOn,
  }) {
    return TestState(
      loadStatus: loadStatus ?? this.loadStatus,
      tests: tests ?? this.tests,
      isMultiOn: isMultiOn ?? this.isMultiOn,
      isOnlyOn: isOnlyOn ?? this.isOnlyOn,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        tests,
        isMultiOn,
        isOnlyOn,
      ];
}
