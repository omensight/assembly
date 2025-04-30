import 'package:flutter/material.dart';

class StandardText extends StatelessWidget {
  const StandardText({
    super.key,
    required this.text,
    this.textType = StandardTextType.body,
  });

  const StandardText.title({super.key, required this.text})
    : textType = StandardTextType.title;

  final String text;
  final StandardTextType textType;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: switch (textType) {
        StandardTextType.title => Theme.of(context).textTheme.titleMedium,
        StandardTextType.body => Theme.of(context).textTheme.bodyMedium,
      },
    );
  }
}

enum StandardTextType { title, body }
