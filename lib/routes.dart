import 'package:assembly/features/auth/presentation/controllers/login_controller.dart';
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
    redirect: (context, state) {
      final serverToken = ref
          .watch(serverTokenProvider)
          .when(
            data: (data) => data,
            error: (error, stackTrace) => null,
            loading: () => null,
          );
      return serverToken == null ? '/login' : null;
    },
  );
}

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return Scaffold(appBar: AppBar(title: Text('Home')));
  }
}
