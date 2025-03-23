import 'package:flutter/material.dart';
import 'package:assembly/core/constants.dart';

class StandardSpace extends StatelessWidget {
  final double space;
  final bool isVertical;
  final double lineStroke;
  const StandardSpace.horizontal({
    super.key,
    this.space = kStandardSpacing,
    this.lineStroke = 0.0,
  }) : isVertical = false;

  const StandardSpace.vertical({
    super.key,
    this.space = kStandardSpacing,
    this.lineStroke = 0.0,
  }) : isVertical = true;

  @override
  Widget build(BuildContext context) {
    final sideSpace = space / 2 - lineStroke / 2;
    final sideSpaceBox = SizedBox(width: sideSpace, height: sideSpace);
    final separatorChildren = [
      sideSpaceBox,
      Visibility(
        visible: lineStroke > 0,
        child: Container(
          width: isVertical ? double.infinity : lineStroke,
          height: isVertical ? lineStroke : double.infinity,
          decoration: const BoxDecoration(color: Colors.black26),
        ),
      ),
      sideSpaceBox,
    ];
    return isVertical
        ? Column(children: separatorChildren)
        : Row(children: separatorChildren);
  }
}
