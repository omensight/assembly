import 'package:assembly/core/data/action_notification.dart';
import 'package:assembly/core/providers/client_providers.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_join_request.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assembly_join_requests_list_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/data_sync_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

class StandardActionsNotifier extends ConsumerWidget {
  const StandardActionsNotifier({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(actionsChannelProvider, (previous, next) {
      final jsonString = next.when(
        data: (data) => data,
        error: (error, stackTrace) => null,
        loading: () => null,
      );
      if (jsonString != null) {
        final actionContent = jsonDecode(jsonString);
        final action = ActionNotification.fromJson(actionContent);
        switch (action.entityName) {
          case ActionNotificationEntity.assembly:
            ref.read(dataSyncControllerProvider.notifier).syncAssemblies();
            break;
          case ActionNotificationEntity.assemblyJoinRequest:
            final data = action.data;
            if (data != null) {
              final assemblyJoinRequest = AssemblyJoinRequest.fromJson(data);
              ref
                  .read(
                    assemblyJoinRequestsListControllerProvider(
                      assemblyJoinRequest.assemblyId,
                    ).notifier,
                  )
                  .removeRequestById(assemblyJoinRequest.id);
            }
            break;

          case ActionNotificationEntity.assemblyMember:
            break;
        }
      }
      ref.watch(actionsChannelProvider);
    });
    return child;
  }
}
