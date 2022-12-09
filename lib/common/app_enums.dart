enum LoadStatus {
  initial,
  loading,
  success,
  fail,
}

enum ConnectionStatus {
  mobileOnline('Mobile network connected'),
  mobileOffline('Mobile network problem'),
  wifiOnline('Wifi network connected'),
  wifiOffline('Wifi network problem'),
  offline('No network');

  final String message;

  const ConnectionStatus(this.message);
}

enum FlushType {
  notification,
  success,
  warning,
  error,
}