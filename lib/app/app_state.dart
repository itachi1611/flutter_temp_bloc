part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.themeMode,
    this.locale,
    this.connectivityResult,
    this.lists,
  });

  final ThemeMode? themeMode;
  final Locale? locale;
  final ConnectivityResult? connectivityResult;
  final List<String>? lists;

  AppState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    ConnectivityResult? connectivityResult,
    List<String>? lists,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      connectivityResult: connectivityResult ?? this.connectivityResult,
      lists: lists ?? this.lists,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        locale,
    connectivityResult,
        lists,
      ];
}
