part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.themeMode,
    this.locale,
    this.connectionStatus,
    this.lists,
  });

  final ThemeMode? themeMode;
  final Locale? locale;
  final ConnectionStatus? connectionStatus;
  final List<String>? lists;

  AppState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    ConnectionStatus? connectionStatus,
    List<String>? lists,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      lists: lists ?? this.lists,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        locale,
        connectionStatus,
        lists,
      ];
}
