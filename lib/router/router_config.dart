import 'package:flutter/widgets.dart';
import 'package:flutter_temp/page/home_shell/home_shell_page.dart';
import 'package:go_router/go_router.dart';

import '../page/index.dart';
import '../page/test/test_page.dart';
import '../page/widgets/transition_page.dart';
import 'routers.dart' show Routers;

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: '_kRoot');
final homeShellKey = GlobalKey<NavigatorState>(debugLabel: '_kHomeShell');
final testShellKey = GlobalKey<NavigatorState>(debugLabel: '_kTestShell');

List<RouteBase> routes = [
  /// Splash page (root)
  _splashRouter,

  /// Home page
  _shellRouter,
];

/// Define child routers
GoRoute get _splashRouter => GoRoute(
  name: Routers.root.routerName,
  path: Routers.root.routerPath,
  pageBuilder: (context, params) => TransitionPage(
    child: const SplashPage(),
    transitionType: PageTransitionType.slideFromRightFade,
  ),
);

StatefulShellRoute get _shellRouter => StatefulShellRoute.indexedStack(

  builder: (context, state, navigatorShell) => HomeShellPage(navigator: navigatorShell),
  branches: [
    // Branch 0 - Home
    _homeBranch,

    // Branch 1 - Test
    _testBranch,
  ],
);

StatefulShellBranch get _homeBranch => StatefulShellBranch(
  navigatorKey: homeShellKey,
  routes: [
    GoRoute(
      name: Routers.home.routerName,
      path: Routers.home.routerPath,
      pageBuilder: (context, params) => TransitionPage(
        child: const HomePage(),
        transitionType: PageTransitionType.slideFromRightFade,
      ),
    ),
  ]
);

StatefulShellBranch get _testBranch => StatefulShellBranch(
    navigatorKey: testShellKey,
    routes: [
      GoRoute(
        name: Routers.test.routerName,
        path: Routers.test.routerPath,
        pageBuilder: (context, params) => TransitionPage(
          child: const TestPage(),
          transitionType: PageTransitionType.slideFromRightFade,
        ),
      ),
    ]
);