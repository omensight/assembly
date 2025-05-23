import 'package:assembly/core/widgets/standar_paddings.dart';
import 'package:assembly/core/widgets/standard_empty_view.dart';
import 'package:assembly/core/widgets/standard_icon_button.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/presentation/controllers/current_assembly_member_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/single_assembly_controller.dart';
import 'package:assembly/features/assemblies/routes.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssemblyDetailPage extends ConsumerWidget {
  final String assemblyId;
  const AssemblyDetailPage({super.key, required this.assemblyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assemblyAsync = ref.watch(
      singleAssemblyControllerProvider(assemblyId),
    );
    final currentAssemblyRole = ref.watch(
      currentAssemblyMemberRoleProvider(assemblyId),
    );
    return Scaffold(
      appBar: AppBar(
        title: assemblyAsync.when(
          data: (data) => Text(data?.name ?? ''),
          error: (error, stackTrace) => SizedBox.shrink(),
          loading: () => CircularProgressIndicator(),
        ),
        actions: [
          StandardIconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              CreateAssignmentRoute(assemblyId: assemblyId).push(context);
            },

            tooltipMessage: LocaleKeys.addAssignment.tr(),
          ),
          StandardIconButton(
            icon: Icon(Icons.group),
            onPressed: () {
              AssemblyMembersRoute(assemblyId: assemblyId).push(context);
            },
          ),
          StandardIconButton(
            icon: Icon(Icons.people_alt_outlined),
            onPressed: () {
              JoinRequestsListRoute(assemblyId: assemblyId).push(context);
            },
          ),
          StandardIconButton(
            icon: Icon(Icons.qr_code_rounded),
            onPressed: () {
              AssemblyJoiningInformationRoute(
                assemblyId: assemblyId,
              ).push(context);
            },
          ),
          if ([AssemblyMemberRole.admin].contains(currentAssemblyRole))
            StandardIconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                EditAssemblyRoute(assemblyId: assemblyId).push(context);
              },
            ),
        ],
      ),
      body: Padding(
        padding: standardHorizontalPadding,
        child: Center(
          child: StandardEmptyView(
            message: LocaleKeys.noEventsYet.tr(),
            title: LocaleKeys.noEventsYetTitle.tr(),
            imagePath: 'assets/empty_views/im_ev_no_events.png',
          ),
        ),
      ),
    );
  }
}
