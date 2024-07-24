import 'package:flutter_temp/config/router/router_config.dart';
import 'package:flutter_temp/page/home/home_page.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';
import 'router_observer.dart';

class AppRouter {
  final GoRouterRefreshStream refreshStream;

  AppRouter(this.refreshStream);

  GoRouter get goRouter => _goRouter;

  GoRouter get _goRouter => GoRouter(
    initialLocation: RouterPage.root.navPath,
    navigatorKey: kRoot,
    debugLogDiagnostics: true,
    refreshListenable: refreshStream,
    errorBuilder: (context, state) => const HomePage(),
    redirect: (context, state) {
      /**
       * * Note: Always check matchedLocation and return with routerPath not routerName
       */
      if(state.matchedLocation == RouterPage.notFoundPage.navPath) {
        return RouterPage.home.navPath;
      }

      return null;
    },
    redirectLimit: 10,
    observers: [RouterObserver()],
    routes: routes,
  );
}

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream._();
  static GoRouterRefreshStream? _instance;
  static GoRouterRefreshStream get instance => _instance ??= GoRouterRefreshStream._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnTokenChange = true; // Init value

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnTokenChange = notify;

  void refreshRouter(BaseAuthUser newUser) {
    initialUser ??= newUser;
    user = newUser;

    // Refresh the app on auth change unless explicitly marked otherwise.
    if (notifyOnTokenChange) {
      notifyListeners();
    }
  }
}

