enum LoadStatus {
  initial,
  loading,
  success,
  fail,
}

enum FlushType {
  notification,
  success,
  warning,
  error,
}

enum LaunchExternalType {
  sms('sms'),
  tel('tel'),
  mail('mailto'),
  webview('https'),
  file('file');

  final String type;

  const LaunchExternalType(this.type);
}

enum Env {
  qa('dev', '_qa'),
  stg('stg', '_stg'),
  prod('', '');

  final String prefixName;

  final String packageName;

  const Env(this.prefixName, this.packageName);
}
