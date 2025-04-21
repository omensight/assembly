import 'package:flutter/material.dart';

class StandardIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final Icon icon;
  final String? tooltipMessage;
  final bool isFilled;
  final double? buttonSize;
  final bool isError;

  const StandardIconButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.tooltipMessage,
    this.isFilled = false,
    this.buttonSize,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child:
          isFilled
              ? IconButton.filled(
                onPressed: onPressed,
                icon: icon,
                style: IconButton.styleFrom(
                  backgroundColor:
                      isError
                          ? Theme.of(
                            context,
                          ).colorScheme.errorContainer.withValues(alpha: .33)
                          : Theme.of(
                            context,
                          ).colorScheme.primaryContainer.withValues(alpha: .33),
                  foregroundColor:
                      isError
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.primary,
                ),

                tooltip: tooltipMessage,
                iconSize: buttonSize != null ? buttonSize! * .4 : null,
              )
              : IconButton(
                onPressed: onPressed,
                icon: icon,
                tooltip: tooltipMessage,
              ),
    );
  }
}
