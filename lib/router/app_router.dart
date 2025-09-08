import 'package:flutter_temp/page/commons/not_found_page.dart';
import 'package:flutter_temp/router/router_config.dart';
import 'package:flutter_temp/router/router_notifier.dart';
import 'package:flutter_temp/router/routers.dart' show Routers;
import 'package:go_router/go_router.dart';

import 'router_observer.dart';

class AppRouter {
  final RouterNotifier routerNotifier;

  AppRouter(this.routerNotifier);

  GoRouter get goRouter => _goRouter;

  GoRouter get _goRouter => GoRouter(
    initialLocation: Uri.base.toString(),
    navigatorKey: rootNavigatorKey,
    debugLogDiagnostics: true,
    refreshListenable: routerNotifier,
    errorBuilder: (context, state) => const NotFoundPage(),
    redirect: (context, state) {
      // Note: Always check matchedLocation and return with routerPath not routerName
      if(state.matchedLocation == Routers.pageNotFound.routerPath) {
        return Routers.home.routerPath;
      }
      return null;
    },
    redirectLimit: 10,
    observers: [RouterObserver()],
    routes: routes,
  );
}

