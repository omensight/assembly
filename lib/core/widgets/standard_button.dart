import 'package:flutter/material.dart';
import 'package:assembly/core/widgets/standard_space.dart';

class StandardButton extends StatelessWidget {
  const StandardButton({
    super.key,
    required this.text,
    this.buttonState = StandardButtonState.standBy,
    this.onPressed,
    this.isForegroundColored = false,
  });

  final String text;
  final StandardButtonState buttonState;
  final void Function()? onPressed;
  final bool isForegroundColored;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:
          isForegroundColored
              ? ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  Theme.of(context).colorScheme.primary,
                ),
                foregroundColor: const WidgetStatePropertyAll(Colors.white),
              )
              : null,
      onPressed: switch (buttonState) {
        StandardButtonState.standBy => onPressed,
        StandardButtonState.loading => null,
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (buttonState == StandardButtonState.loading) ...const [
            SizedBox(width: 18, height: 18, child: CircularProgressIndicator()),
            StandardSpace.horizontal(),
          ],
          Text(text),
        ],
      ),
    );
  }
}

enum StandardButtonState { standBy, loading }
