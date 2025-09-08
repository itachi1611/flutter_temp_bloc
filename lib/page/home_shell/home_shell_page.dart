import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/page/home_shell/home_shell_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../app/common_widgets/fox_bottom_navigation_bar.dart';
import '../../common/app_shadows.dart';

class HomeShellPage extends StatefulWidget {
  final StatefulNavigationShell navigator;

  const HomeShellPage({super.key, required this.navigator});

  @override
  State<HomeShellPage> createState() => _HomeShellPageState();
}

class _HomeShellPageState extends State<HomeShellPage> {
  late final HomeShellCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<HomeShellCubit>(context);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  void onChangeBottomNavigationBarItem(int shellIndex, int currentIndex) {
    if(shellIndex == currentIndex) {
      widget.navigator.goBranch(shellIndex, initialLocation: true);
    } else {
      _cubit.onChangeBottomNavigationBarItem(shellIndex);
      widget.navigator.goBranch(shellIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocSelector<HomeShellCubit, HomeShellState, int>(
        selector: (state) => state.shellIndex,
        builder: (context, shellIndex) {
          return Scaffold(
              body: PageTransitionSwitcher(
                duration: const Duration(milliseconds: 300),
                reverse: false,
                transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
                  return FadeThroughTransition(
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                  );
                },
                child: widget.navigator,
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  border: const Border(
                    top: BorderSide(color: Colors.black, width: 0),
                  ),
                  boxShadow: AppShadows.bottomNavigationBarShadow,
                ),
                child: FoxBottomNavigationBar(
                  currentIndex: shellIndex,
                  onTapItem: (index) => onChangeBottomNavigationBarItem(index, shellIndex),
                ),
              ),
          );
        },
      ),
    );
  }
}
