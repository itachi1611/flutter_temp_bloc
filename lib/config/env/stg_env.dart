import 'package:envied/envied.dart';

import '../../common/app_env.dart';

part 'stg_env.g.dart';

@Envied(name: 'Env', path: 'assets/env/.env.stg')
class StgEnv implements AppEnv {
  @override
  @EnviedField(varName: 'BASE_URL')
  final String baseUrl = _Env.baseUrl;
}