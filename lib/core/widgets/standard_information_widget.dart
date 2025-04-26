import 'package:assembly/core/widgets/standard_container.dart';
import 'package:assembly/core/widgets/standard_space.dart';
import 'package:flutter/material.dart';

class StandardInformationWidget extends StatelessWidget {
  const StandardInformationWidget({
    super.key,
    this.icon,
    required this.text,
    this.isContentCentered = false,
  });

  final Widget? icon;
  final String text;
  final bool isContentCentered;

  @override
  Widget build(BuildContext context) {
    return StandardContainer(
      forceBorderDrawing: true,
      child: Row(
        mainAxisAlignment:
            isContentCentered
                ? MainAxisAlignment.center
                : MainAxisAlignment.start,
        children: [
          if (icon != null) ...[icon!, const StandardSpace.horizontal()],
          if (icon == null) const Icon(Icons.info_outline),
          const StandardSpace.horizontal(),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}
