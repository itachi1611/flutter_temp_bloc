import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/generated/l10n.dart';
import 'package:flutter_temp/main.dart';
import 'package:flutter_temp/utils/app_connection.dart';
import 'package:flutter_temp/utils/app_flush_bar.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/app_cubit.dart';
import '../../utils/app_dialog.dart';
import '../../utils/app_logger.dart';
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
    _appCubit = BlocProvider.of<AppCubit>(context);
    _homeCubit = HomeCubit();

    _networkConnectivity.initialise();

    _networkConnectivity.myStream.listen((source) {
      _source = source;
      appLogger.i('source $_source');
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          _appCubit.setConnectionStatus(_source.values.toList()[0] ? ConnectionStatus.mobileOnline : ConnectionStatus.mobileOffline);
          break;
        case ConnectivityResult.wifi:
          _appCubit.setConnectionStatus(_source.values.toList()[0] ? ConnectionStatus.wifiOnline : ConnectionStatus.wifiOffline);
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
  }

  void onCheckPermission() async => await appPermission.onHandlePermissionStatus();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocConsumer<AppCubit, AppState>(
          bloc: _appCubit,
          listener: (context, state) {
            switch(state.connectionStatus) {
              case ConnectionStatus.mobileOffline:
              case ConnectionStatus.wifiOffline:
              case ConnectionStatus.offline:
                // AppFlushBar.showFlushBar(context, message: state.connectionStatus?.message.toString().trim(), type: FlushType.error);
                AppDialog.showCustomDialog(context,title: 'test', content: 'contentttttt');
                break;
              case ConnectionStatus.mobileOnline:
              case ConnectionStatus.wifiOnline:
              default:
                // AppFlushBar.showFlushBar(context, message: state.connectionStatus?.message.toString().trim(), type: FlushType.success);
                AppDialog.showCustomDialog(context,title: 'test', content: 'contentttttt');
                break;
            }
          },
          listenWhen: (pre, cur) => pre.connectionStatus != cur.connectionStatus,
          builder: (context, state) {
            return Column(
              children: [
                Switch(
                  inactiveThumbColor: Colors.green,
                  inactiveTrackColor: Colors.pink[200],
                  activeColor: Colors.blue,
                  activeTrackColor: Colors.pink[200],
                  value: state.themeMode == ThemeMode.light ? true : false,
                  onChanged: (val) {
                    _appCubit.onChangeSwitch(val);
                  },
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  bloc: _homeCubit,
                  builder: (context, state) {
                    return DropdownButton(
                      items: state.lists!
                          .map<DropdownMenuItem<String>>((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (val) {
                        _appCubit.setLocale(val);
                      },
                    );
                  },
                ),
                Text(S.current.title),
              ],
            );
          },
        ),
      ),
    );
  }

  void onGranted() {
    AppLogger.instance.i('granted');
  }

  void onDenied() {
    AppLogger.instance.i('denied');
  }

  @override
  void dispose() {
    _networkConnectivity.disposeStream();
    appPermission.dispose();
    super.dispose();
  }
}
