import 'package:flutter/material.dart';
import 'package:assembly/core/widgets/standard_space.dart';

class StandardButton extends StatelessWidget {
  const StandardButton({
    super.key,
    required this.text,
    this.buttonState = StandardButtonState.standBy,
    this.onPressed,
    this.customBackgroundColor,
    this.isBackgroundColored = false,
  });

  final String text;
  final StandardButtonState buttonState;
  final void Function()? onPressed;
  final Color? customBackgroundColor;
  final bool isBackgroundColored;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style:
          isBackgroundColored
              ? ElevatedButton.styleFrom(
                backgroundColor:
                    customBackgroundColor ??
                    Theme.of(context).colorScheme.primary,
                foregroundColor:
                    customBackgroundColor != null || isBackgroundColored
                        ? Colors.white
                        : null,
              )
              : null,
      onPressed: switch (buttonState) {
        StandardButtonState.standBy => onPressed,
        StandardButtonState.loading => null,
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (buttonState == StandardButtonState.loading) ...[
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                color:
                    isBackgroundColored
                        ? Colors.white
                        : Theme.of(context).colorScheme.primary,
              ),
            ),
            StandardSpace.horizontal(),
          ],
          Text(text),
        ],
      ),
    );
  }
}

enum StandardButtonState { standBy, loading }
