import 'package:flutter/material.dart';

class StandardIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final Icon icon;
  final String? tooltipMessage;

  const StandardIconButton({
    super.key,
    this.onPressed,
    required this.icon,
    this.tooltipMessage,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      tooltip: tooltipMessage,
    );
  }
}
