import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_temp/utils/app_logger.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app_page.dart';

final appLogger = AppLogger.instance;

Future<void> main() async {
  /// Initialize packages
  WidgetsFlutterBinding.ensureInitialized();

  /// Set higher display refresh rate for Android target
  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }

  /// Init hive storage
  final Directory tmpDir = await getTemporaryDirectory();
  Hive.init(tmpDir.toString());
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : tmpDir,
  );

  runApp(const AppPage());
}
