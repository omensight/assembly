import 'package:assembly/features/assemblies/presentation/pages/assembly_detail_page/assembly_detail_page.dart';
import 'package:assembly/features/assemblies/presentation/pages/assembly_joining_information_page/assembly_joining_information_page.dart';
import 'package:assembly/features/assemblies/presentation/pages/assembly_members_page/assembly_members_page.dart';
import 'package:assembly/features/assemblies/presentation/pages/assignment_detail_page/assignment_detail_page.dart';
import 'package:assembly/features/assemblies/presentation/pages/create_assembly_page/create_assembly_page.dart';
import 'package:assembly/features/assemblies/presentation/pages/create_assignment/create_assignment_settings_page/create_assignment_settings_page.dart';
import 'package:assembly/features/assemblies/presentation/pages/create_assignment/create_assignment_page/create_assignment_page.dart';
import 'package:assembly/features/assemblies/presentation/pages/edit_assembly_page/edit_assembly_page.dart';
import 'package:assembly/features/assemblies/presentation/pages/join_requests_list_page/join_requests_list_page.dart';
import 'package:assembly/features/assemblies/presentation/pages/scan_assembly_join_code_page/scan_assembly_join_code_page.dart';
import 'package:assembly/features/assemblies/presentation/pages/user_assemblies_page/user_assemblies_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

part 'routes.g.dart';

final assemblyRoutes = $appRoutes;

@TypedGoRoute<UserAssembliesRoute>(path: '/assemblies')
class UserAssembliesRoute extends GoRouteData with _$UserAssembliesRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return UserAssembliesPage();
  }
}

@TypedGoRoute<CreateAssemblyRoute>(path: '/create-assembly')
class CreateAssemblyRoute extends GoRouteData with _$CreateAssemblyRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CreateAssemblyPage();
  }
}

@TypedGoRoute<AssemblyDetailRoute>(path: '/assembly')
class AssemblyDetailRoute extends GoRouteData with _$AssemblyDetailRoute {
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
class AssemblyJoiningInformationRoute extends GoRouteData
    with _$AssemblyJoiningInformationRoute {
  final String assemblyId;

  AssemblyJoiningInformationRoute({required this.assemblyId});
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AssemblyJoiningInformationPage(assemblyId: assemblyId);
  }
}

@TypedGoRoute<ScanAssemblyJoinCodeRoute>(path: '/scan-assembly-join-code')
class ScanAssemblyJoinCodeRoute extends GoRouteData
    with _$ScanAssemblyJoinCodeRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ScanAssemblyJoinCodePage();
  }
}

@TypedGoRoute<JoinRequestsListRoute>(path: '/assembly-join-requests')
class JoinRequestsListRoute extends GoRouteData with _$JoinRequestsListRoute {
  final String assemblyId;

  JoinRequestsListRoute({required this.assemblyId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return JoinRequestsListPage(assemblyId: assemblyId);
  }
}

@TypedGoRoute<AssemblyMembersRoute>(path: '/assembly-members')
class AssemblyMembersRoute extends GoRouteData with _$AssemblyMembersRoute {
  final String assemblyId;

  AssemblyMembersRoute({required this.assemblyId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AssemblyMembersPage(assemblyId: assemblyId);
  }
}

@TypedGoRoute<EditAssemblyRoute>(path: '/edit-assembly')
class EditAssemblyRoute extends GoRouteData with _$EditAssemblyRoute {
  final String assemblyId;

  EditAssemblyRoute({required this.assemblyId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return EditAssemblyPage(assemblyId: assemblyId);
  }
}

@TypedGoRoute<CreateAssignmentRoute>(path: '/create-assignment')
class CreateAssignmentRoute extends GoRouteData with _$CreateAssignmentRoute {
  final String assemblyId;

  CreateAssignmentRoute({required this.assemblyId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CreateAssignmentPage(assemblyId: assemblyId);
  }
}

@TypedGoRoute<CreateAssignmentSettingsRoute>(
  path: '/create-assignment-settings',
)
class CreateAssignmentSettingsRoute extends GoRouteData
    with _$CreateAssignmentSettingsRoute {
  final String assemblyId;
  final String assignmentId;

  CreateAssignmentSettingsRoute({
    required this.assemblyId,
    required this.assignmentId,
  });

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return CreateAssignmentSettingsPage(
      assemblyId: assemblyId,
      assignmentId: assignmentId,
    );
  }
}

@TypedGoRoute<AssignmentDetailRoute>(path: '/assignment-detail')
class AssignmentDetailRoute extends GoRouteData with _$AssignmentDetailRoute {
  final String assemblyId;
  final String assignmentId;

  AssignmentDetailRoute({required this.assemblyId, required this.assignmentId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return AssignmentDetailPage(
      assemblyId: assemblyId,
      assignmentId: assignmentId,
    );
  }
}
