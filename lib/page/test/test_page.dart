import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/ext/widget_ext.dart';
import 'package:flutter_temp/main.dart';
import 'package:flutter_temp/page/test/test_cubit.dart';
import 'package:flutter_temp/page/widgets/flutter_animation_pre_build/open_container_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/app_colors.dart';
import '../../utils/app_utils.dart';
import '../widgets/glass_widget.dart';

class TestPage extends StatefulWidget {
  const TestPage({
    Key? key,
    required this.textColor,
  }) : super(key: key);

  final Color textColor;

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
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<TestCubit, TestState>(
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
      ),
    );
  }

  Widget get glassBlur {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(
            'https://i.guim.co.uk/img/media/d143e03bccd1150ef52b8b6abd7f3e46885ea1b3/0_182_5472_3283/master/5472.jpg?width=1200&height=900&quality=85&auto=format&fit=crop&s=3b777fd8aa2e7e97efb6a5a17eed7537'),
        filterQuality: FilterQuality.high,
        fit: BoxFit.cover,
      )),
      child: const GlassWidget(),
    );
  }

  Widget get _launcherWidget {
    return Column(
      children: [
        Text('Sms', style: GoogleFonts.sourceCodePro(color: widget.textColor))
            .inkwell(() => AppUtils.onLaunchExternalApp(
                externalType: LaunchExternalType.sms, data: "+1234567890")),
        Text('Tel', style: GoogleFonts.sourceCodePro(color: widget.textColor))
            .inkwell(() => AppUtils.onLaunchExternalApp(
                externalType: LaunchExternalType.tel, data: "+1234567890")),
        Text('Email', style: GoogleFonts.sourceCodePro(color: widget.textColor))
            .inkwell(() async => AppUtils.onLaunchExternalApp(
                externalType: LaunchExternalType.mail, data: "+1234567890")),
        Text('WebView',
                style: GoogleFonts.sourceCodePro(color: widget.textColor))
            .inkwell(() => AppUtils.onLaunchExternalApp(
                externalType: LaunchExternalType.webview,
                data: "www.google.com")),
      ],
    );
  }

  // Widget  _collapseView(bool isOn) {
  //   return ListView(
  //     scrollDirection: Axis.vertical,
  //     physics: const BouncingScrollPhysics(),
  //     shrinkWrap: true,
  //     children: [
  //       ListView(
  //         shrinkWrap: true,
  //         children: [
  //           AnimatedContainer(
  //             duration: const Duration(milliseconds: 350),
  //             child: InkWell(
  //               highlightColor: Colors.transparent,
  //               splashColor: Colors.transparent,
  //               onTap: () => cubit.toggle(),
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const Icon(Icons.wallet),
  //                   const Text('Multi'),
  //                   AnimatedSwitcher(
  //                     duration: const Duration(milliseconds: 350),
  //                     child: isOn // state.isMultiOn!
  //                         ? const Icon(Icons.arrow_drop_down)
  //                         : const Icon(Icons.arrow_drop_up),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //           AnimatedCrossFade(
  //             firstChild: const SizedBox.shrink(),
  //             secondChild: ListView.separated(
  //               shrinkWrap: true,
  //               itemBuilder: (context, index) {
  //                 return Container(
  //                   height: 50,
  //                   color: Colors.transparent,
  //                   child: Text(index.toString()),
  //                 );
  //               },
  //               separatorBuilder: (context, index) {
  //                 return const SizedBox(height: 5);
  //               },
  //               itemCount: 5,
  //             ),
  //             crossFadeState: isOn
  //                 ? CrossFadeState.showSecond
  //                 : CrossFadeState.showFirst,
  //             duration: const Duration(milliseconds: 350),
  //           )
  //         ],
  //       )
  //     ],
  //   );
  // }

  Widget get _success => BlocBuilder<TestCubit, TestState>(
        buildWhen: (pre, cur) =>
            pre.isMultiOn != cur.isMultiOn || pre.isOnlyOn != cur.isOnlyOn,
        builder: (context, state) {
          int key = (widget.key as ValueKey<int>).value;

          switch (key) {
            case 0:
              return Container(
                color: widget.textColor.withOpacity(0.5),
                alignment: Alignment.center,
                child: _launcherWidget,
              ).center;
            case 1:
              return Container(
                color: widget.textColor.withOpacity(0.5),
                child: material3,
              );
            case 2:
              const dataLength = 20;
              var data =
                  List<String>.generate(dataLength, (index) => "Number $index")
                      .toList(growable: true);
              return ListView.separated(
                itemBuilder: (context, index) {
                  return OpenContainerWrapper(
                      closedBuilder: (context, openContainer) {
                        return InkWell(
                          onTap: openContainer,
                          child: Container(
                              height: 50,
                              color: Colors.pinkAccent.withOpacity(0.4),
                              child: Text(data[index].toString())),
                        );
                      },
                      transitionType: ContainerTransitionType.fade,
                      onClosed: (val) {
                        logger.i(val);
                      },
                      target: Container(
                        color: Colors.orange,
                      ));
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 5);
                },
                itemCount: data.length,
              );
            case 3:
            default:
              return Container(
                color: widget.textColor.withOpacity(0.5),
                child: _launcherWidget,
              );
          }
        },
      );

  Widget get material3 {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Material 3',
                style: GoogleFonts.sourceCodePro(fontWeight: FontWeight.bold)),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1A1C1C),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  /// Account section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Text(
                          'Account',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Row(
                          children: [
                            const CircleAvatar(backgroundColor: Colors.red),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Arlene McCoy',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.15,
                                    color: AppColors.darkTextWhite,
                                  ),
                                ),
                                Text(
                                  '@msmccoy',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.25,
                                    color: AppColors.lightTextGray,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(36),
                                color: AppColors.lightGray,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sign out',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lightTextWhite,
                                      letterSpacing: 0.1,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.logout_rounded,
                                    size: 20,
                                    color: AppColors.lightTextGray,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),

                  const Divider(
                    thickness: 1,
                    color: Color(0xFFBBC9CA),
                  ),
                  /// Music section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Text(
                          'Music',
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                        child: Row(
                          children: [
                            const CircleAvatar(backgroundColor: Colors.red),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Arlene McCoy',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.15,
                                    color: AppColors.darkTextWhite,
                                  ),
                                ),
                                Text(
                                  '@msmccoy',
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.25,
                                    color: AppColors.lightTextGray,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(36),
                                color: AppColors.lightGray,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sign out',
                                    style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.lightTextWhite,
                                      letterSpacing: 0.1,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.logout_rounded,
                                    size: 20,
                                    color: AppColors.lightTextGray,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
