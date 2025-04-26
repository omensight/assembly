import 'package:assembly/core/widgets/standard_space.dart';
import 'package:flutter/material.dart';

class StandardEmptyView extends StatelessWidget {
  const StandardEmptyView({
    super.key,
    this.imagePath,
    required this.message,
    this.title,
  });
  final String? imagePath;
  final String? title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imagePath != null) Image.asset(imagePath!, width: 200),
          const StandardSpace.vertical(),
          if (title != null)
            Text(title!, style: Theme.of(context).textTheme.titleMedium),
          const StandardSpace.vertical(),
          Text(message),
        ],
      ),
    );
  }
}
