import 'package:flutter/material.dart';

class StandardSwitch extends StatelessWidget {
  const StandardSwitch({
    super.key,
    required this.title,
    required this.description,
    required this.switchStateNotifier,
  });

  final String title;
  final String description;
  final ValueNotifier<bool> switchStateNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.titleMedium),
              Text(description),
            ],
          ),
        ),
        Switch(
          value: switchStateNotifier.value,
          onChanged: (value) {
            switchStateNotifier.value = value;
          },
        ),
      ],
    );
  }
}
