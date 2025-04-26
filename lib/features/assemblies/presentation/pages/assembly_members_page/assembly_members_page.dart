import 'package:assembly/core/widgets/standar_paddings.dart';
import 'package:assembly/core/widgets/standard_container.dart';
import 'package:assembly/core/widgets/standard_empty_view.dart';
import 'package:assembly/core/widgets/standard_space.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assembly_members_controller.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AssemblyMembersPage extends ConsumerWidget {
  final String assemblyId;

  const AssemblyMembersPage({super.key, required this.assemblyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membersAsync = ref.watch(
      assemblyMembersControllerProvider(assemblyId),
    );

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.assemblyMembers.tr())),
      body: Padding(
        padding: standardHorizontalPadding,
        child: membersAsync.when(
          data:
              (members) =>
                  members.isEmpty
                      ? Center(
                        child: StandardEmptyView(
                          imagePath: 'assets/empty_views/im_ev_no_events.png',
                          message: LocaleKeys.noMembersFound.tr(),
                        ),
                      )
                      : ListView.separated(
                        separatorBuilder:
                            (context, index) => const StandardSpace.vertical(),
                        itemCount: members.length,
                        itemBuilder: (context, index) {
                          final member = members[index];
                          return StandardContainer(
                            forceBorderDrawing: true,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'User ID: ${member.userId}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Role: ${member.role.name.toUpperCase()}',
                                      style: TextStyle(
                                        color:
                                            member.role ==
                                                    AssemblyMemberRole.admin
                                                ? Colors.purple
                                                : Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(
                                  member.role == AssemblyMemberRole.admin
                                      ? Icons.admin_panel_settings
                                      : Icons.person,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error:
              (error, stackTrace) => Center(
                child: Text(
                  '${LocaleKeys.failureLoadingAssemblyMembers.tr()}: $error',
                ),
              ),
        ),
      ),
    );
  }
}
