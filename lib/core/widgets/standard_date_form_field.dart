import 'package:assembly/core/constants.dart';
import 'package:assembly/core/text_validators/common_text_validator.dart';
import 'package:assembly/core/widgets/standard_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StandardDateFormField extends HookWidget {
  const StandardDateFormField({
    super.key,
    required this.label,
    this.onDateChanged,
  });

  final String label;
  final Function(DateTime dateTime)? onDateChanged;

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
        showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        ).then((value) {
          if (value != null) {
            final formattedDate = kStandardDateFormat.format(value);
            dateTextController.text = formattedDate;
            onDateChanged?.call(value);
          }
        });
      },
    );
  }
}
