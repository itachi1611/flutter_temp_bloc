class AppConfig {
  static const String appName = 'Temp';
  static const String env = 'uat';

  ///Network
  static const baseUrl = 'https://63a15ce4e3113e5a5c5305f2.mockapi.io';
  // static const baseUrl = (env == 'live' || env == '')
  //     ? 'https://api.propcom.vn'
  //     : env == 'staging'
  //         ? 'https://stagingapi.propcom.vn'
  //         : env == "uat"
  //             ? "https://spx-uat-api.nws-dev.com"
  //             : 'https://spx-api.nws-dev.com';
}
