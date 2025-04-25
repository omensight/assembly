import 'package:assembly/features/assemblies/presentation/pages/assembly_detail_page/assembly_detail_page.dart';
import 'package:assembly/features/assemblies/presentation/pages/assembly_joining_information_page/assembly_joining_information_page.dart';
import 'package:assembly/features/assemblies/presentation/pages/create_assembly_page/create_assembly_page.dart';
import 'package:assembly/features/assemblies/presentation/pages/edit_assembly_page/edit_assembly_page.dart';
import 'package:assembly/features/assemblies/presentation/pages/join_requests_list_page/join_requests_list_page.dart';
import 'package:assembly/features/assemblies/presentation/pages/scan_assembly_join_code_page/scan_assembly_join_code_page.dart';
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

@TypedGoRoute<CreateAssemblyRoute>(path: '/create-assembly')
class CreateAssemblyRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CreateAssemblyPage();
  }
}

@TypedGoRoute<AssemblyDetailRoute>(path: '/assembly')
class AssemblyDetailRoute extends GoRouteData {
  final String assemblyId;

  AssemblyDetailRoute({required this.assemblyId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AssemblyDetailPage(assemblyId: assemblyId);
  }
}

@TypedGoRoute<AssemblyJoiningInformationRoute>(
  path: '/assembly-joining-information',
)
class AssemblyJoiningInformationRoute extends GoRouteData {
  final String assemblyId;

  AssemblyJoiningInformationRoute({required this.assemblyId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AssemblyJoiningInformationPage(assemblyId: assemblyId);
  }
}

@TypedGoRoute<ScanAssemblyJoinCodeRoute>(path: '/scan-assembly-join-code')
class ScanAssemblyJoinCodeRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ScanAssemblyJoinCodePage();
  }
}

@TypedGoRoute<JoinRequestsListRoute>(path: '/assembly-join-requests')
class JoinRequestsListRoute extends GoRouteData {
  final String assemblyId;

  JoinRequestsListRoute({required this.assemblyId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return JoinRequestsListPage(assemblyId: assemblyId);
  }
}

@TypedGoRoute<EditAssemblyRoute>(path: '/edit-assembly')
class EditAssemblyRoute extends GoRouteData {
  final String assemblyId;

  EditAssemblyRoute({required this.assemblyId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EditAssemblyPage(assemblyId: assemblyId);
  }
}
