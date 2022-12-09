import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_temp/generated/l10n.dart';

import '../common/app_themes.dart';
import '../page/splash/splash_page.dart';
import 'app_cubit.dart';

class AppPage extends StatelessWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppCubit>(create: (context) {
          return AppCubit();
        }),
      ],
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (pre, cur) => pre.themeMode != cur.themeMode || pre.locale != cur.locale,
        builder: (context, state) {
          return MaterialApp(
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
            supportedLocales: S.delegate.supportedLocales,
            locale: state.locale,
            debugShowCheckedModeBanner: false,
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
