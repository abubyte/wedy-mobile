import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wedy/config/routes/routes.dart';
import 'package:wedy/features/authentication/views/login/login_screen.dart';
import 'package:wedy/features/authentication/views/register/register_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
// final GlobalKey<NavigatorState> _sectionANavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

class AppRouter {
  static final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.login, // TODO: use splash
    routes: [
      GoRoute(path: Routes.splash, builder: (context, state) => const SizedBox()),
      GoRoute(path: Routes.login, builder: (context, state) => const LoginView()),
      GoRoute(path: Routes.register, builder: (context, state) => const RegisterView()),
      GoRoute(
        path: Routes.verify,
        builder: (context, state) {
          final String login = (state.extra as Map<String, dynamic>)['login'];
          final String password = (state.extra as Map<String, dynamic>)['password'];

          return const SizedBox();
        },
      ), // TODO implement verify
      //   StatefulShellRoute.indexedStack( // TODO
      //     builder: (context, state, navigationShell) => NavigationScreen(child: navigationShell),
      //     branches: [
      //       StatefulShellBranch(
      //         routes: [
      //           GoRoute(path: Routes.home, builder: (context, state) => const SizedBox()),
      //           GoRoute(path: Routes.create, builder: (context, state) => const SizedBox()),
      //           GoRoute(path: Routes.favorite, builder: (context, state) => const SizedBox()),
      //           GoRoute(path: Routes.profile, builder: (context, state) => const SizedBox()),
      //         ],
      //       ),
      //     ],
      //   ),
    ],
  );
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 0),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation, child: child);
    },
  );
}
