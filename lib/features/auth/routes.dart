import 'package:assembly/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
part 'routes.g.dart';

final authRoutes = $appRoutes;

@TypedGoRoute<LoginRoute>(path: '/login')
class LoginRoute extends GoRouteData with _$LoginRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LoginPage();
  }
}
