import 'package:assembly/core/widgets/standard_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StandardFormFieldPassword extends HookWidget {
  final String label;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final TextEditingController? controller;
  const StandardFormFieldPassword({
    super.key,
    required this.label,
    this.validator,
    this.onEditingComplete,
    this.onChanged,
    this.controller,
  });
  @override
  Widget build(BuildContext context) {
    final isPasswordVisible = useState(false);

    return StandardTextFormField(
      label: label,
      controller: controller,
      obscureText: !isPasswordVisible.value,
      onChanged: onChanged,
      suffixIcon: IconButton(
        onPressed: () {
          isPasswordVisible.value = !isPasswordVisible.value;
        },
        icon: Icon(
          isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
        ),
      ),
      validator: validator,
      onEditingComplete: onEditingComplete,
    );
  }
}
