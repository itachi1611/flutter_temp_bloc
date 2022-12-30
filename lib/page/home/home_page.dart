import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/ext/widget_ext.dart';
import 'package:flutter_temp/main.dart';
import 'package:flutter_temp/page/setting/setting_page.dart';
import 'package:flutter_temp/utils/app_connection.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/app_cubit.dart';
import '../../utils/app_dialog.dart';
import '../../utils/app_permission.dart';
import 'home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppCubit _appCubit;
  late final HomeCubit _homeCubit;
  late final AppPermission appPermission;

  Map _source = {ConnectivityResult.none: false};
  final AppConnection _networkConnectivity = AppConnection.instance;

  @override
  void initState() {
    super.initState();
    _appCubit = BlocProvider.of<AppCubit>(context)..setListLang();
    _homeCubit = HomeCubit();

    _networkConnectivity.initialise();

    _networkConnectivity.myStream.listen((source) {
      _source = source;
      appLogger.i('source $_source');
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          _appCubit.setConnectionStatus(_source.values.toList()[0]
              ? ConnectionStatus.mobileOnline
              : ConnectionStatus.mobileOffline);
          break;
        case ConnectivityResult.wifi:
          _appCubit.setConnectionStatus(_source.values.toList()[0]
              ? ConnectionStatus.wifiOnline
              : ConnectionStatus.wifiOffline);
          break;
        case ConnectivityResult.none:
        default:
          _appCubit.setConnectionStatus(ConnectionStatus.offline);
          break;
      }
    });

    _homeCubit.initData();
    appPermission = AppPermission(
        permission: Permission.camera,
        actionGranted: onGranted,
        actionDenied: onDenied);
    onCheckPermission();

    onTrace();
  }

  void onTrace() async {
    Trace trace = performance!.newTrace('custom-trace');

    await trace.start();

    // Set metrics you wish to track
    trace.setMetric('sum', 200);
    trace.setMetric('time', 342340435);

    // `sum` will be incremented to 201
    trace.incrementMetric('sum', 1);

    trace.putAttribute('userId', '1234');

    trace.stop();
  }

  void onCheckPermission() async =>
      await appPermission.onHandlePermissionStatus();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocListener<AppCubit, AppState>(
          bloc: _appCubit,
          listener: (context, state) =>
              onConnectionChangedListener(state.connectionStatus),
          listenWhen: (pre, cur) =>
              pre.connectionStatus != cur.connectionStatus,
          child: BlocBuilder<HomeCubit, HomeState>(
            bloc: _homeCubit,
            buildWhen: (pre, cur) => pre.loadStatus != cur.loadStatus,
            builder: (context, state) {
              switch (state.loadStatus) {
                case LoadStatus.loading:
                  return const CircularProgressIndicator().center;
                case LoadStatus.fail:
                  return const Text('Load fail').center;
                case LoadStatus.success:
                default:
                  return SettingPage(appCubit: _appCubit);
              }
            },
          ),
        ),
      ),
    );
  }

  void onGranted() => appLogger.i('granted');

  void onDenied() => appLogger.i('denied');

  void onConnectionChangedListener(ConnectionStatus? connectionStatus) {
    switch (connectionStatus) {
      case ConnectionStatus.mobileOffline:
      case ConnectionStatus.wifiOffline:
      case ConnectionStatus.offline:
        // AppFlushBar.showFlushBar(context, message: state.connectionStatus?.message.toString().trim(), type: FlushType.error);
        AppDialog.showCustomDialog(context,
            title: 'test',
            content: 'contentttttt',
            barrierDismissible: true,
            barrierLabel: '');
        break;
      case ConnectionStatus.mobileOnline:
      case ConnectionStatus.wifiOnline:
      default:
        // AppFlushBar.showFlushBar(context, message: state.connectionStatus?.message.toString().trim(), type: FlushType.success);
        AppDialog.showCustomDialog(context,
            title: 'test',
            content: 'contentttttt',
            barrierDismissible: true,
            barrierLabel: '');
        break;
    }
  }

  @override
  void dispose() {
    _networkConnectivity.disposeStream();
    appPermission.dispose();
    _homeCubit.close();
    _appCubit.close();
    super.dispose();
  }
}
