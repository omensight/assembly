import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:assembly/generated/locale_keys.g.dart';

class StandardTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;
  final StandardInputType standardInputType;
  final Function()? onEditingComplete;
  final Function(String value)? onChanged;
  final Function()? onTap;
  final String? prefix;
  final EditState editState;
  final bool isOutlinedStyle;
  final TextAlign textAlign;
  final bool showLabel;
  final bool showErrorText;
  final Widget? suffix;
  final bool reducedTagSizes;
  final int minLines;
  final int maxLines;
  final TextStyle? textStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxLength;
  final String? errorText;

  final bool obscureText;
  final FocusNode? focusNode;
  const StandardTextFormField({
    super.key,
    this.label = '',
    this.controller,
    this.validator,
    this.standardInputType = StandardInputType.any,
    this.onEditingComplete,
    this.onChanged,
    this.prefix,
    this.editState = EditState.editable,
    this.isOutlinedStyle = true,
    this.textAlign = TextAlign.start,
    this.showLabel = true,
    this.suffix,
    this.showErrorText = true,
    this.reducedTagSizes = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.textStyle,
    this.suffixIcon,
    this.obscureText = false,
    this.onTap,
    this.focusNode,
    this.prefixIcon,
    this.maxLength,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: editState == EditState.readOnly,
      validator: validator,
      textAlignVertical: TextAlignVertical.center,
      textAlign: textAlign,
      minLines: minLines,
      maxLines: maxLines,
      style:
          textStyle ??
          (editState == EditState.readOnly
              ? TextStyle(color: Colors.black54)
              : null),
      obscureText: obscureText,
      focusNode: focusNode,
      maxLength: maxLength,
      decoration: InputDecoration(
        errorText: errorText,
        border: isOutlinedStyle ? const OutlineInputBorder() : null,
        label:
            showLabel
                ? Text(switch (editState) {
                  EditState.editable => label,
                  EditState.readOnly => label,
                  EditState.optional => LocaleKeys.optionalTag.tr(
                    args: [label],
                  ),
                })
                : null,
        errorMaxLines: 3,
        errorStyle:
            showErrorText ? null : const TextStyle(height: 0, fontSize: 0),
        prefix: prefix != null ? Text(prefix!) : null,
        suffix: suffix,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        labelStyle: reducedTagSizes ? const TextStyle(fontSize: 10) : null,
        prefixStyle: reducedTagSizes ? const TextStyle(fontSize: 10) : null,
      ),
      keyboardType: switch (standardInputType) {
        StandardInputType.decimal => const TextInputType.numberWithOptions(
          decimal: true,
        ),
        StandardInputType.numeric => TextInputType.number,
        StandardInputType.phoneNumber => TextInputType.phone,
        StandardInputType.any => null,
      },
      textCapitalization: TextCapitalization.sentences,
      inputFormatters: switch (standardInputType) {
        StandardInputType.decimal => [
          FilteringTextInputFormatter.allow(RegExp(r'^(\d{0,15})?\.?\d{0,3}')),
        ],
        StandardInputType.numeric => [
          FilteringTextInputFormatter.allow(RegExp(r'^(0|[1-9]\d{0,8})')),
        ],
        StandardInputType.phoneNumber => [
          FilteringTextInputFormatter.allow(RegExp(r'^\+\d*$|\d*')),
        ],
        StandardInputType.any => null,
      },
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}

enum StandardInputType { numeric, decimal, any, phoneNumber }

enum EditState { editable, readOnly, optional }
