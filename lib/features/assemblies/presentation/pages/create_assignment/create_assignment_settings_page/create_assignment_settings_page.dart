import 'package:assembly/core/text_validators/common_text_validator.dart';
import 'package:assembly/core/widgets/standar_paddings.dart';
import 'package:assembly/core/widgets/standard_date_form_field.dart';
import 'package:assembly/core/widgets/standard_space.dart';
import 'package:assembly/core/widgets/standard_switch.dart';
import 'package:assembly/core/widgets/standard_text.dart';
import 'package:assembly/core/widgets/standard_text_form_field.dart';
import 'package:assembly/core/widgets/standard_time_form_field.dart';
import 'package:assembly/features/assemblies/presentation/controllers/assignments/assignment_controller.dart';
import 'package:assembly/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddAssignmentDetailsPage extends HookConsumerWidget {
  final String assemblyId;
  final String assignmentId;
  const AddAssignmentDetailsPage({
    super.key,
    required this.assemblyId,
    required this.assignmentId,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final assignmentAsync = ref.watch(
      assignmentControllerProvider(assemblyId, assignmentId),
    );
    final turnDurationController = useTextEditingController();

    final formKey = useMemoized(() => GlobalKey<FormState>());
    final commonTextValidator = useMemoized(() => CommonTextValidator());
    final assignmentType = useState<AssignmentType>(AssignmentType.individual);
    final repeatEntireCycleState = useState<bool>(true);
    final isAutomaticGroupSizeState = useState<bool>(true);
    final startDateState = useState<DateTime?>(null);
    final turnDurationState = useState<int>(0);
    final groupSizeState = useState<int>(0);
    useEffect(() {
      final isAutomaticGroupSize = isAutomaticGroupSizeState.value;
      if (!isAutomaticGroupSize) {
        groupSizeState.value = 0;
      }
      return;
    }, [isAutomaticGroupSizeState.value]);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          assignmentAsync.when(
            data: (data) => data.name,
            error: (error, stackTrace) => '',
            loading: () => '',
          ),
        ),
      ),
      body: Padding(
        padding: standardPadding,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StandardText.title(text: LocaleKeys.startDateAndTime.tr()),
                const StandardSpace.vertical(),
                StandardDateFormField(
                  label: LocaleKeys.startDate.tr(),
                  onDateChanged: (dateTime) {
                    startDateState.value = dateTime;
                  },
                ),
                const StandardSpace.vertical(),
                StandardTimeFormField(label: LocaleKeys.cycleResetTime.tr()),
                const StandardSpace.vertical(),
                SizedBox(
                  width: double.infinity,
                  child: StandardSwitch(
                    title: LocaleKeys.repeatEntireCycleTitle.tr(),
                    description: LocaleKeys.repeatEntireCycleDescription.tr(),
                    switchStateNotifier: repeatEntireCycleState,
                  ),
                ),
                const StandardSpace.vertical(),
                StandardText.title(text: LocaleKeys.turns.tr()),
                const StandardSpace.vertical(),
                StandardTextFormField(
                  controller: turnDurationController,
                  label: LocaleKeys.turnDuration.tr(),
                  standardInputType: StandardInputType.numeric,
                  validator:
                      (value) => commonTextValidator.requiredField(value),
                  prefixIcon: Icon(Icons.data_object_rounded),
                  onChanged:
                      (value) =>
                          turnDurationState.value = int.tryParse(value) ?? 0,
                ),
                const StandardSpace.vertical(),
                StandardText.title(text: LocaleKeys.memberGrouping.tr()),
                SizedBox(
                  width: double.infinity,
                  child: SegmentedButton(
                    segments:
                        AssignmentType.values
                            .map(
                              (e) => ButtonSegment(
                                value: e,
                                label: switch (e) {
                                  AssignmentType.individual => Text(
                                    LocaleKeys.asignmentTypeIndividual.tr(),
                                  ),
                                  AssignmentType.group => Text(
                                    LocaleKeys.asignmentTypeGroup.tr(),
                                  ),
                                },
                              ),
                            )
                            .toList(),
                    selected: {assignmentType.value},
                    onSelectionChanged: (value) {
                      assignmentType.value = value.first;
                    },
                  ),
                ),
                if (assignmentType.value == AssignmentType.group) ...[
                  const StandardSpace.vertical(),
                  StandardSwitch(
                    title:
                        LocaleKeys.splitTheMembersIntoGroupsAutomaticallyTitle
                            .tr(),
                    description:
                        LocaleKeys
                            .splitTheMembersIntoGroupsAutomaticallyDescription
                            .tr(),
                    switchStateNotifier: isAutomaticGroupSizeState,
                  ),
                  const StandardSpace.vertical(),
                  if (isAutomaticGroupSizeState.value) ...[
                    const StandardSpace.vertical(),
                    StandardTextFormField(
                      label: LocaleKeys.groupSize.tr(),
                      standardInputType: StandardInputType.numeric,
                      prefixIcon: Icon(Icons.group),
                      validator:
                          (value) => commonTextValidator.requiredField(value),
                      onChanged:
                          (value) =>
                              groupSizeState.value = int.tryParse(value) ?? 0,
                    ),
                  ],
                ],
                if (turnDurationState.value > 0) ...[
                  const StandardSpace.vertical(),
                  switch (assignmentType.value) {
                    AssignmentType.individual => StandardText(
                      text: LocaleKeys.automaticIndividualGroupsSelectionNotice
                          .tr(args: [turnDurationState.value.toString()]),
                    ),
                    AssignmentType.group =>
                      isAutomaticGroupSizeState.value
                          ? groupSizeState.value > 0
                              ? StandardText(
                                text: LocaleKeys
                                    .automaticGroupGroupsSelectionNotice
                                    .tr(
                                      args: [
                                        turnDurationState.value.toString(),
                                        groupSizeState.value.toString(),
                                      ],
                                    ),
                              )
                              : SizedBox.shrink()
                          : StandardText(
                            text: LocaleKeys.manualGroupsSelectionNotice.tr(),
                          ),
                  },
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum AssignmentType { individual, group }
