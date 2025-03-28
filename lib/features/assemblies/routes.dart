import 'package:assembly/features/assemblies/presentation/pages/user_assemblies_page/user_assemblies_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

final assemblyRoutes = $appRoutes;

@TypedGoRoute<UserAssembliesRoute>(path: '/assemblies')
class UserAssembliesRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return UserAssembliesPage();
  }
}
