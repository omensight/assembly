import 'package:assembly/core/widgets/standard_space.dart';
import 'package:flutter/material.dart';

class StandardEmptyView extends StatelessWidget {
  const StandardEmptyView({super.key, this.imagePath, required this.message});
  final String? imagePath;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (imagePath != null) Image.asset(imagePath!, width: 200),
        const StandardSpace.vertical(),
        Text(message),
      ],
    );
  }
}
