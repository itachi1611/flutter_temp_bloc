import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_displaymode/flutter_displaymode.dart';
import 'package:flutter_temp/database/app_shared_preference.dart';
import 'package:flutter_temp/utils/app_logger.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app_page.dart';
import 'firebase_options.dart';
import 'models/m.hive/user.dart';

final logger = AppLogger.instance;


Future<void> main() async {
  /// Initialize packages
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).whenComplete(() async {

  });

  /// Set higher display refresh rate for Android target
  if (Platform.isAndroid) {
    await FlutterDisplayMode.setHighRefreshRate();
  }

  /// Init hive storage
  final Directory tmpDir = await getTemporaryDirectory();
  Hive.init(tmpDir.toString());
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb ? HydratedStorage.webStorageDirectory : tmpDir,
  );

  Hive.init(tmpDir.path.toString());
  Hive.registerAdapter(UserAdapter());

  AppSharedPreference.init();

  runApp(const AppPage());
}
