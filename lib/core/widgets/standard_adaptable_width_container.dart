import 'package:flutter/material.dart';

class StandardAdaptableWidthContainer extends StatelessWidget {
  final Widget child;
  final bool isCentered;
  const StandardAdaptableWidthContainer({
    super.key,
    required this.child,
    this.isCentered = true,
  });

  @override
  Widget build(BuildContext context) {
    return isCentered
        ? Align(
            alignment: Alignment.topCenter,
            child: buildConstrainedBox(),
          )
        : buildConstrainedBox();
  }

  Widget buildConstrainedBox() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: child,
    );
  }
}
