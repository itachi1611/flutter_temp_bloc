import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_temp/generated/l10n.dart';
import 'package:flutter_temp/page/home_shell/home_shell_cubit.dart';
import 'package:flutter_temp/router/app_router.dart';
import 'package:flutter_temp/router/router_notifier.dart';
import 'package:flutter_temp/services/firebase_notification_service.dart';
import 'package:flutter_temp/services/network_service.dart';
import 'package:flutter_temp/utils/app_logger.dart';
import 'package:go_router/go_router.dart';

import '../common/app_themes.dart';
import 'app_cubit.dart';

late final GoRouter appRouter;
late final NetworkService networkService;

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {

  @override
  void initState() {
    super.initState();

    appRouter = AppRouter(RouterNotifier()).goRouter;
    networkService = NetworkService.instance..initialize();
    networkService.connectStream.listen(_onConnectionChanged);

    FirebaseNotificationService.instance.onTokenRefresh.listen((token) {
      // Todo: Send to backend if needed
      simpleLog('📲 New token: $token');
    });

    FirebaseNotificationService.instance.onMessage.listen((message) {
      // Todo: Add extra work here
      simpleLog('Foreground message: $message');
    });

    FirebaseNotificationService.instance.onMessageOpenedApp.listen((message) {
      // Todo: Navigate to specific page
      simpleLog('App opened from notification: $message');
    });

    FirebaseNotificationService.instance.onNotificationTap.listen((payload) {
      simpleLog('Local notification tapped, payload:  $payload');
    });
  }

  void _onConnectionChanged(bool isConnected) {
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(create: (context) {
          return AppCubit();
        }),
        BlocProvider<HomeShellCubit>(create: (context) {
          return HomeShellCubit();
        }),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (pre, cur) => pre.themeMode != cur.themeMode || pre.locale != cur.locale,
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            /// Theme
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state.themeMode,
            /// Localization stuff
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              S.delegate,
            ],
            routerConfig: appRouter,
            supportedLocales: S.delegate.supportedLocales,
            locale: state.locale,
            builder: (context, child) {
              final mediaQueryData = MediaQuery.of(context);

              return MediaQuery(
                data:
                mediaQueryData.copyWith(textScaler: TextScaler.noScaling),
                child: child!,
              );
            }
          );
        },
      ),
    );
  }
}
