import 'package:assembly/core/widgets/standard_button.dart';
import 'package:assembly/features/assemblies/domain/entities/assignment_group.dart';
import 'package:assembly/features/assemblies/domain/entities/assembly_member.dart';
import 'package:assembly/features/assemblies/presentation/controllers/current_assembly_member_controller.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignment_detail_provider.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/confirm_assignment_group_completion_controller.dart';
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
      final role = ref.watch(currentAssemblyMemberRoleProvider(assemblyId));
      if (role == AssemblyMemberRole.admin) {
        final confirmProvider =
            confirmAssignmentGroupCompletionControllerProvider(
              assemblyId: assemblyId,
              assignmentId: assignmentGroup.assignmentId,
              assignmentGroupId: assignmentGroup.id,
            );
        final confirmState = ref.watch(confirmProvider);

        ref.listen<AsyncValue<void>>(confirmProvider, (previous, next) {
          // Success path: transitioned from loading to data
          final wasLoading = previous?.isLoading == true;
          if (wasLoading && next.hasValue && !next.isLoading) {
            ref.invalidate(
              assignmentDetailDTOProvider(
                assemblyId,
                assignmentGroup.assignmentId,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  LocaleKeys.assignmentGroupCompletionConfirmed.tr(),
                ),
              ),
            );
          }

          next.whenOrNull(
            error: (error, stack) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    LocaleKeys.failureConfirmingAssignmentGroupCompletion.tr(),
                  ),
                ),
              );
            },
          );
        });

        return Row(
          children: [
            Expanded(
              child: Text(
                LocaleKeys.awaitingConfirmation.tr(),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.deepOrange),
              ),
            ),
            StandardButton(
              text: LocaleKeys.confirm.tr(),
              buttonState:
                  confirmState.isLoading
                      ? StandardButtonState.loading
                      : StandardButtonState.standBy,
              onPressed: () {
                ref.read(confirmProvider.notifier).confirm();
              },
              isBackgroundColored: true,
            ),
          ],
        );
      }
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
