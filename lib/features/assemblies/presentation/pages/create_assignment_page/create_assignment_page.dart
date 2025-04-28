import 'package:assembly/core/text_validators/common_text_validator.dart';
import 'package:assembly/core/widgets/standar_paddings.dart';
import 'package:assembly/core/widgets/standard_button.dart';
import 'package:assembly/core/widgets/standard_text_form_field.dart';
import 'package:assembly/features/assemblies/presentation/controllers/create_assignment_controller.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateAssignmentPage extends HookConsumerWidget {
  final String assemblyId;

  const CreateAssignmentPage({super.key, required this.assemblyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final rotationDurationController = useTextEditingController();
    final formKey = useMemoized(() => GlobalKey<FormState>());

    final state = ref.watch(createAssignmentControllerProvider);
    final commonTextValidator = useMemoized(() => CommonTextValidator());

    ref.listen(createAssignmentControllerProvider, (previous, next) {
      next.whenData((assignment) {
        if (assignment != null && previous?.value != assignment) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(LocaleKeys.assignmentCreatedSuccessfully.tr()),
            ),
          );
          Navigator.of(context).pop();
        }
      });

      next.whenOrNull(
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                LocaleKeys.errorCreatingAssignment.tr(args: [error.toString()]),
              ),
            ),
          );
        },
      );
    });

    return Scaffold(
      appBar: AppBar(title: Text(LocaleKeys.createAssignment.tr())),
      body: Padding(
        padding: standardHorizontalPadding,
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: ListView(
            children: [
              SizedBox(height: 16),
              StandardTextFormField(
                controller: nameController,
                label: LocaleKeys.assignmentName.tr(),
                validator: (value) => commonTextValidator.requiredField(value),
              ),
              SizedBox(height: 16),
              StandardTextFormField(
                controller: descriptionController,
                label: LocaleKeys.assignmentDescription.tr(),
                maxLines: 3,
                validator: (value) => commonTextValidator.requiredField(value),
              ),
              SizedBox(height: 16),
              StandardTextFormField(
                controller: rotationDurationController,
                label: LocaleKeys.rotationDuration.tr(),
                standardInputType: StandardInputType.numeric,
                validator: (value) => commonTextValidator.requiredField(value),
              ),
              SizedBox(height: 24),
              StandardButton(
                text: LocaleKeys.createAssignment.tr(),
                buttonState:
                    state.isLoading
                        ? StandardButtonState.loading
                        : StandardButtonState.standBy,
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    final name = nameController.text;
                    final description = descriptionController.text;
                    final rotationDuration = int.parse(
                      rotationDurationController.text,
                    );

                    ref
                        .read(createAssignmentControllerProvider.notifier)
                        .createAssignment(
                          assemblyId: assemblyId,
                          name: name,
                          description: description,
                          rotationDuration: rotationDuration,
                        );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
