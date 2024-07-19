import 'dart:async';

import 'package:animations/animations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/common/app_shadows.dart';
import 'package:flutter_temp/extensions/context_ext.dart';
import 'package:flutter_temp/extensions/widget_ext.dart';
import 'package:flutter_temp/page/test/test_page.dart';
import 'package:flutter_temp/page/widgets/flutter_animation_pre_build/shared_axis_transition_wrapper.dart';
import 'package:flutter_temp/utils/app_connection.dart';
import 'package:flutter_temp/utils/app_logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/app_cubit.dart';
import '../../app/common_widgets/fox_bottom_navigation_bar.dart';
import '../../utils/app_permission.dart';
import '../../utils/fcm_manager.dart';
import 'home_cubit.dart';
import 'widgets/home_loading_example_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppCubit _appCubit;
  late final HomeCubit _homeCubit;
  late final AppPermission appPermission;

  late final StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  final _listPages = [
    const TestPage(textColor: Colors.blue, key: ValueKey(0)),
    const TestPage(textColor: Colors.green, key: ValueKey(1)),
    const TestPage(textColor: Colors.red, key: ValueKey(2)),
    const TestPage(textColor: Colors.yellow, key: ValueKey(3))
  ];

  final _appConnection = AppConnection();

  bool initExistConnectionNetwork = true;

  @override
  void initState() {
    onGetFCMToken();
    super.initState();
    _appCubit = BlocProvider.of<AppCubit>(context)..setListLang();
    _homeCubit = HomeCubit();

    _connectivitySubscription = _appConnection.connectivityStream.listen(onListenConnection);

    _homeCubit.initData();
    appPermission = AppPermission(
      permission: Permission.camera,
      actionGranted: onGranted,
      actionDenied: onDenied,
    );

    onCheckPermission(); // Request system permission
    setupInteractedMessage(); // Listen FCM
    onFCMTokenUpdated.listen(onTokenReceived);
  }

  void onCheckPermission() async => await appPermission.onHandlePermissionStatus();

  void onListenConnection(List<ConnectivityResult> results) {
    final currentStatus = results.first;

    if(currentStatus == ConnectivityResult.none) {
      if(initExistConnectionNetwork) {
        _appCubit.setConnectionStatus(currentStatus);
        initExistConnectionNetwork = false;
      }
    } else {
      if(!initExistConnectionNetwork) {
        _appCubit.setConnectionStatus(currentStatus);
        initExistConnectionNetwork = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AppCubit, AppState>(
        bloc: _appCubit,
        listener: (context, state) => onConnectionChangedListener(state.connectivityResult ?? ConnectivityResult.none),
        listenWhen: (pre, cur) => pre.connectivityResult != cur.connectivityResult,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: BlocBuilder<HomeCubit, HomeState>(
            bloc: _homeCubit,
            buildWhen: (pre, cur) => pre.loadStatus != cur.loadStatus || pre.currentIndex != cur.currentIndex,
            builder: (context, state) {
              switch (state.loadStatus) {
                case LoadStatus.loading:
                  return HomeLoadingExamplePage();
                case LoadStatus.fail:
                  return const Text('Load fail').center;
                case LoadStatus.success:
                default:
                  return SharedAxisTransitionWrapper(
                    isReverse: true,
                    transitionType: SharedAxisTransitionType.scaled,
                    target: _listPages[state.currentIndex],
                  );
              }
            },
          ),
          bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
            bloc: _homeCubit,
            buildWhen: (pre, cur) => pre.currentIndex != cur.currentIndex,
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  border: const Border(
                    top: BorderSide(color: Colors.black, width: 0),
                  ),
                  boxShadow: AppShadows.bottomNavigationBarShadow,
                ),
                child: FoxBottomNavigationBar(
                  currentIndex: state.currentIndex,
                  onTapItem: onChangedBottomBarItem,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void onGranted() => AppLogger().i('granted');

  void onDenied() => AppLogger().i('denied');

  void onChangedBottomBarItem(int index) => _homeCubit.onChangedIndex(index);

  void onConnectionChangedListener(ConnectivityResult connectivityResult) => context.onConnectionChanged(connectivityResult);

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    appPermission.dispose();
    _homeCubit.close();
    _appCubit.close();
    super.dispose();
  }
}
