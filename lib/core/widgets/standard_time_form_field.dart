import 'package:assembly/core/text_validators/common_text_validator.dart';
import 'package:assembly/core/widgets/standard_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StandardTimeFormField extends HookWidget {
  const StandardTimeFormField({
    super.key,
    required this.label,
    this.onTimeOfDayChanged,
  });

  final String label;
  final Function(TimeOfDay timeOfDay)? onTimeOfDayChanged;

  @override
  Widget build(BuildContext context) {
    final dateTextController = useTextEditingController();
    final commonTextValidator = useMemoized(() => CommonTextValidator());
    return StandardTextFormField(
      prefixIcon: Icon(Icons.calendar_today),
      label: label,
      controller: dateTextController,
      validator: (value) => commonTextValidator.requiredField(value),
      editState: EditState.readOnly,
      onTap: () {
        FocusScope.of(context).unfocus();
        showTimePicker(
          context: context,
          initialTime: TimeOfDay(hour: 8, minute: 0),
        ).then((value) {
          if (value != null && context.mounted) {
            final formattedDate = value.format(context);
            dateTextController.text = formattedDate;
            onTimeOfDayChanged?.call(value);
          }
        });
      },
    );
  }
}
