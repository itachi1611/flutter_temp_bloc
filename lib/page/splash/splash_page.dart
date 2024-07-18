import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/ext/widget_ext.dart';
import 'package:splash_view/splash_view.dart';

import '../home/home_page.dart';
import 'splash_cubit.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashCubit _splashCubit;

  @override
  void initState() {
    super.initState();
    _splashCubit = SplashCubit();
    _splashCubit.getDeviceInfo();
    _splashCubit.onAnimateLogo();
  }

  @override
  void dispose() {
    _splashCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      bloc: _splashCubit,
      buildWhen: (pre, cur) => pre.logoStyle != cur.logoStyle,
      builder: (context, state) {
        return SplashView(
          logo: FlutterLogo(
            size: state.logoStyle != FlutterLogoStyle.markOnly ? 160 : 96,
            textColor: state.textColor,
            style: state.logoStyle,
          ),
          loadingIndicator: const CircularProgressIndicator().paddingEach(
              t: 20, b: 20),
          backgroundColor: Colors.white,
          //title: const Text('FLUTTER'),
          //subtitle: const Text('Welcome to community !'),
          bottomLoading: true,
          duration: const Duration(seconds: 3),
          showStatusBar: false,
          done: Done(
            const HomePage(),
            animationDuration: const Duration(milliseconds: 500),
            curve: Curves.fastLinearToSlowEaseIn,
          ),
        );
      },
    );
  }
}
