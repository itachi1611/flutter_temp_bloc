part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.themeMode,
    this.locale,
    this.lists,
  });

  final ThemeMode? themeMode;
  final Locale? locale;
  final List<String>? lists;

  AppState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    List<String>? lists,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      lists: lists ?? this.lists,
    );
  }

  @override
  List<Object?> get props => [
    themeMode,
    locale,
    lists,
  ];
}
