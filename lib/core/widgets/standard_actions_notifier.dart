import 'package:assembly/core/data/action_notification.dart';
import 'package:assembly/core/providers/client_providers.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';


class StandardActionsNotifier extends ConsumerWidget {
  const StandardActionsNotifier({super.key, required this.child});

  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      actionsChannelProvider,
      (previous, next) {
        final jsonString = next.when(
          data: (data) => data,
          error: (error, stackTrace) => null,
          loading: () => null,
        );
        if (jsonString != null) {
          final actionContent = jsonDecode(jsonString);
          final action = ActionNotification.fromJson(actionContent);
          switch (action.entity) {
            case ActionNotificationEntity.assembly:
              break;
          }
        }
        ref.watch(actionsChannelProvider);
      },
    );
    return child;
  }
}
