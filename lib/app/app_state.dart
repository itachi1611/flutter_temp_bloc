part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState({
    this.themeMode,
    this.locale,
    this.connectionStatus,
  });

  final ThemeMode? themeMode;
  final Locale? locale;
  final ConnectionStatus? connectionStatus;

  AppState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    ConnectionStatus? connectionStatus,
  }) {
    return AppState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      connectionStatus: connectionStatus ?? this.connectionStatus,
    );
  }

  @override
  List<Object?> get props => [
        themeMode,
        locale,
        connectionStatus,
      ];
}
