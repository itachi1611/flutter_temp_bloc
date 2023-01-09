import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/ext/loading_animation_ext.dart';
import 'package:flutter_temp/ext/widget_ext.dart';
import 'package:flutter_temp/main.dart';
import 'package:flutter_temp/utils/app_connection.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/app_cubit.dart';
import '../../utils/app_flush_bar.dart';
import '../../utils/app_permission.dart';
import '../../utils/app_utils.dart';
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
      logger.i('source $_source');
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
  }

  void onCheckPermission() async => await appPermission.onHandlePermissionStatus();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocListener<AppCubit, AppState>(
          bloc: _appCubit,
          listener: (context, state) => onConnectionChangedListener(state.connectionStatus),
          listenWhen: (pre, cur) => pre.connectionStatus != cur.connectionStatus,
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
                  return _launcherWidget;
              }
            },
          ),
        ),
      ),
    );
  }

  void onGranted() => logger.i('granted');

  void onDenied() => logger.i('denied');

  void onConnectionChangedListener(ConnectionStatus? connectionStatus) {
    switch (connectionStatus) {
      case ConnectionStatus.mobileOffline:
      case ConnectionStatus.wifiOffline:
      case ConnectionStatus.offline:
        AppFlushBar.showFlushBar(context, message: connectionStatus?.message.toString().trim(), type: FlushType.error);
        break;
      case ConnectionStatus.mobileOnline:
      case ConnectionStatus.wifiOnline:
      default:
        break;
    }
  }

  Widget get _loadingWidget {
    var listTitle = LoadingAnimationType.values.map((e) => e.title).toList();
    var list = LoadingAnimationType.values.map((e) => e.loadingWidget).toList();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0
      ),
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.pinkAccent,
            border: Border.all(color: Colors.grey),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(listTitle[index], style: GoogleFonts.sourceCodePro(fontSize: 10)),
              list[index],
            ],
          ),
        );
      },
      itemCount: list.length,
    );
  }

  Widget get _launcherWidget {
    return Column(
      children: [
        const Text('Sms').inkwell(() => AppUtils.onLaunchExternalApp(externalType: LaunchExternalType.sms, data: "+1234567890")),
        const Text('Tel').inkwell(() => AppUtils.onLaunchExternalApp(externalType: LaunchExternalType.tel, data: "+1234567890")),
        const Text('Email').inkwell(() async => AppUtils.onLaunchExternalApp(externalType: LaunchExternalType.mail, data: "+1234567890")),
        const Text('WebView').inkwell(() => AppUtils.onLaunchExternalApp(externalType: LaunchExternalType.webview, data: "www.github.com/mustafatahirhussein")),
      ],
    );
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
