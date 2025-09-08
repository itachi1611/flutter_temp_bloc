import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/extensions/widget_ext.dart';
import 'package:flutter_temp/utils/app_logger.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../app/app_cubit.dart';
import '../../utils/app_permission.dart';
import '../widgets/animation_wrapper/shared_axis_transition_wrapper.dart';
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

  @override
  void initState() {
    super.initState();
    _appCubit = BlocProvider.of<AppCubit>(context)..setListLang();
    _homeCubit = HomeCubit();

    _homeCubit.initData();
    appPermission = AppPermission(
      permission: Permission.camera,
      actionGranted: onGranted,
      actionDenied: onDenied,
    );

    onCheckPermission(); // Request system permission
  }

  void onCheckPermission() async => await appPermission.onHandlePermissionStatus();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: BlocBuilder<HomeCubit, HomeState>(
          bloc: _homeCubit,
          buildWhen: (pre, cur) => pre.loadStatus != cur.loadStatus || pre.currentIndex != cur.currentIndex,
          builder: (context, state) {
            switch (state.loadStatus) {
              case LoadStatus.loading:
                return const CircularProgressIndicator();
              case LoadStatus.fail:
                return const Text('Load fail').center;
              case LoadStatus.success:
              default:
                return SharedAxisTransitionWrapper(
                  isReverse: true,
                  transitionType: SharedAxisTransitionType.scaled,
                  target: Container(color: Colors.red),
                );
            }
          },
        ),
      ),
    );
  }

  void onGranted() => info('granted');

  void onDenied() => info('denied');

  void onChangedBottomBarItem(int index) => _homeCubit.onChangedIndex(index);

  @override
  void dispose() {
    appPermission.dispose();
    _homeCubit.close();
    _appCubit.close();
    super.dispose();
  }
}
