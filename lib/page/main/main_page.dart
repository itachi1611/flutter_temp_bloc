import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/ext/widget_ext.dart';
import 'package:flutter_temp/page/home/home_page.dart';
import 'package:flutter_temp/page/main/main_cubit.dart';

import '../test/test_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final MainCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = MainCubit();
    _cubit.checkFirstRunNavigate();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      bloc: _cubit,
      listener: (context, state) {
        if(state.navigationType == FirstRunNavigationType.firstRun) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const TestPage(textColor: Colors.green)));
        } else if(state.navigationType == FirstRunNavigationType.notFirstRun) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
        }
      },
      listenWhen: (pre, cur) => pre.navigationType != cur.navigationType,
      buildWhen: (pre, cur) => pre.loadStatus != cur.loadStatus,
      builder: (context, state) {
        return const CircularProgressIndicator().center;
      },
    );
  }
}
