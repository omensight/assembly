import 'package:assembly/features/auth/domain/models/authentication_state.dart';
import 'package:assembly/features/auth/presentation/controllers/login_controller.dart';
import 'package:assembly/features/auth/presentation/pages/splash_screen/splash_screen.dart';
import 'package:assembly/features/auth/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'routes.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    routes: [...$appRoutes, ...authRoutes],
    initialLocation: SplashRoute().location,
    redirect: (context, state) {
      final authenticationState = ref.watch(authenticationStateProvider);

      return authenticationState == AuthenticationState.unauthenticated
          ? LoginRoute().location
          : '/';
    },
  );
}

@TypedGoRoute<SplashRoute>(path: '/loading')
class SplashRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SplashScreen();
  }
}

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(body: Center(child: Text('Home')));
  }
}
