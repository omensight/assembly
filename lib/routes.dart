import 'package:assembly/features/assemblies/routes.dart';
import 'package:assembly/features/auth/domain/models/authentication_state.dart';
import 'package:assembly/features/auth/presentation/controllers/login_controller.dart';
import 'package:assembly/features/auth/presentation/pages/splash_screen/splash_screen.dart';
import 'package:assembly/features/auth/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'routes.g.dart';

@riverpod
GoRouter router(Ref ref) {
  return GoRouter(
    routes: [...$appRoutes, ...authRoutes, ...assemblyRoutes],
    initialLocation: UserAssembliesRoute().location,
    redirect: (context, state) {
      final authenticationState = ref.watch(authenticationStateProvider);

      return authenticationState == AuthenticationState.unauthenticated
          ? LoginRoute().location
          : null;
    },
  );
}

@TypedGoRoute<SplashRoute>(path: '/loading')
class SplashRoute extends GoRouteData with _$SplashRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return SplashScreen();
  }
}
