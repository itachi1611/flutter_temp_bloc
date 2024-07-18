import 'dart:async';

import 'package:animations/animations.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/common/app_colors.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/common/app_extension.dart';
import 'package:flutter_temp/common/app_shadows.dart';
import 'package:flutter_temp/ext/loading_animation_ext.dart';
import 'package:flutter_temp/ext/widget_ext.dart';
import 'package:flutter_temp/page/test/test_page.dart';
import 'package:flutter_temp/page/widgets/flutter_animation_pre_build/shared_axis_transition_wrapper.dart';
import 'package:flutter_temp/utils/app_connection.dart';
import 'package:flutter_temp/utils/app_logger.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/app_cubit.dart';
import '../../utils/app_flush_bar.dart';
import '../../utils/app_permission.dart';
import 'home_cubit.dart';

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
    super.initState();
    _appCubit = BlocProvider.of<AppCubit>(context)..setListLang();
    _homeCubit = HomeCubit();

    _connectivitySubscription = _appConnection.connectivityStream.listen(onListenConnection);

    _homeCubit.initData();
    appPermission = AppPermission(
        permission: Permission.camera,
        actionGranted: onGranted,
        actionDenied: onDenied);
    onCheckPermission();
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
            buildWhen: (pre, cur) =>
                pre.loadStatus != cur.loadStatus ||
                pre.currentIndex != cur.currentIndex,
            builder: (context, state) {
              switch (state.loadStatus) {
                case LoadStatus.loading:
                  return _loadingWidget;
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
                child: BottomNavigationBar(
                  items: _bottomBar,
                  currentIndex: state.currentIndex,
                  onTap: (int index) {
                    _homeCubit.onChangedIndex(index);
                  },
                  elevation: 0,
                  // When set type to shifting => consider set background color for each BottomNavigationBarItem
                  // When set type to fixed => consider set background color at backgroundColor || fixedColor at BottomNavigationBar
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  //fixedColor: Colors.orange.withOpacity(0.6),
                  iconSize: 24,
                  selectedItemColor: AppColors.navActiveItemColor,
                  unselectedItemColor: AppColors.navUnActiveItemColor,
                  selectedFontSize: 16,
                  unselectedFontSize: 14,
                  selectedLabelStyle: GoogleFonts.sourceCodePro(
                    //fontSize: 20, // Override selectedFontSize attribute
                    // color: Colors.white,
                  ),
                  unselectedLabelStyle: GoogleFonts.sourceCodePro(
                    //fontSize: 20, // Override unselectedFontSize attribute
                    //color: Colors.purpleAccent,
                  ),
                  selectedIconTheme: const IconThemeData(
                    color: AppColors.navActiveItemColor, // Override selectedItemColor attribute
                    opacity: 0.8,
                    size: 24, // Override iconSize attribute
                  ),
                  unselectedIconTheme: const IconThemeData(
                    color: AppColors.navUnActiveItemColor, // Override unselectedItemColor attribute
                    opacity: 0.8,
                    size: 24, // Override iconSize attribute
                  ),
                  showUnselectedLabels: true,
                  showSelectedLabels: true,
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

  void onConnectionChangedListener(ConnectivityResult connectivityResult) {
    switch (connectivityResult) {
      case ConnectivityResult.none:
        AppFlushBar.showFlushBar(context,
            message: connectivityResult.message.toString().trim(),
            type: FlushType.error);
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        AppFlushBar.showFlushBar(context,
          message: connectivityResult.message.toString().trim(),
          type: FlushType.notification);
        break;
      case ConnectivityResult.vpn:
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.other:
      default:
        break;
    }
  }

  Widget get _loadingWidget {
    var listTitle = LoadingAnimationType.values.map((e) => e.title).toList();
    var list = LoadingAnimationType.values.map((e) => e.loadingWidget).toList();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
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
              Text(listTitle[index],
                  style: GoogleFonts.sourceCodePro(fontSize: 10)),
              list[index],
            ],
          ),
        );
      },
      itemCount: list.length,
    );
  }

  /// Component Widgets
  List<BottomNavigationBarItem> get _bottomBar => [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          activeIcon: Icon(Icons.home_max_rounded),
          backgroundColor: Colors
              .white, // Will be override if backgroundColor form BottomNavigationBar has been set
          label: 'Home',
          tooltip: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.flutter_dash_rounded),
          activeIcon: Icon(Icons.flutter_dash_rounded),
          backgroundColor: Colors.white,
          label: 'Flutter School',
          tooltip: 'Flutter School',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.abc_rounded),
          activeIcon: Icon(Icons.back_hand_rounded),
          backgroundColor: Colors.white,
          label: 'Testing',
          tooltip: 'Testing',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings_rounded),
          activeIcon: Icon(Icons.settings_backup_restore_rounded),
          backgroundColor: Colors.white,
          label: 'Setting',
          tooltip: 'Setting',
        ),
      ];

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    appPermission.dispose();
    _homeCubit.close();
    _appCubit.close();
    super.dispose();
  }
}
