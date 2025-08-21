import 'package:assembly/core/widgets/standard_button.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_group.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignment_detail_provider.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MarkAssignmentGroupAsCompletedWidget extends ConsumerWidget {
  const MarkAssignmentGroupAsCompletedWidget({
    super.key,
    required this.assignmentGroup,
    required this.assemblyId,
  });

  final String assemblyId;
  final AssignmentGroup assignmentGroup;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completion = assignmentGroup.completion;
    final isMarkedAsCompleted = completion != null;
    final isConfirmed = completion?.isConfirmed ?? false;

    if (isMarkedAsCompleted && isConfirmed) {
      return Text(
        LocaleKeys.assingnmentCompleted.tr(),
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }

    if (isMarkedAsCompleted && !isConfirmed) {
      return Text(
        LocaleKeys.awaitingConfirmation.tr(),
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(color: Colors.deepOrange),
      );
    }

    final markAsCompletionStatus = ref.watch(
      markAssignmentGroupCompletedControllerProvider(
        assemblyId: assemblyId,
        assignmentGroupId: assignmentGroup.id,
        assignmentId: assignmentGroup.assignmentId,
      ),
    );

    return StandardButton(
      buttonState:
          markAsCompletionStatus.isLoading
              ? StandardButtonState.loading
              : StandardButtonState.standBy,
      text: LocaleKeys.markAsCompleted.tr(),
      onPressed: () {
        ref
            .read(
              markAssignmentGroupCompletedControllerProvider(
                assemblyId: assemblyId,
                assignmentGroupId: assignmentGroup.id,
                assignmentId: assignmentGroup.assignmentId,
              ).notifier,
            )
            .markGroupAsCompleted();
      },
      isBackgroundColored: true,
    );
  }
}
