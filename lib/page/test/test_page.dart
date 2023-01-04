import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/ext/widget_ext.dart';
import 'package:flutter_temp/page/test/test_cubit.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> with TickerProviderStateMixin {
  late final TestCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = TestCubit();
    cubit.init();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<TestCubit, TestState>(
        buildWhen: (pre, cur) => pre.loadStatus != cur.loadStatus,
        builder: (context, state) {
          switch (state.loadStatus) {
            case LoadStatus.loading:
              return const CircularProgressIndicator().center;
            case LoadStatus.fail:
              return const Text('Load fail').center;
            default:
              return _success;
          }
        },
      ),
    );
  }

  Widget get _success => BlocBuilder<TestCubit, TestState>(
      buildWhen: (pre, cur) =>
          pre.isMultiOn != cur.isMultiOn || pre.isOnlyOn != cur.isOnlyOn,
      builder: (context, state) {
        return ListView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 350),
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () => cubit.toggle(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.wallet),
                        const Text('Multi'),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 350),
                          child: state.isMultiOn!
                              ? const Icon(Icons.arrow_drop_down)
                              : const Icon(Icons.arrow_drop_up),
                        ),
                      ],
                    ),
                  ),
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox.shrink(),
                  secondChild: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        color: Colors.transparent,
                        child: Text(index.toString()),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 5);
                    },
                    itemCount: 5,
                  ),
                  crossFadeState: state.isMultiOn!
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 350),
                )
              ],
            )
          ],
        );
      },
    );
}
