import 'package:flutter/material.dart';
import 'package:assembly/core/constants.dart';
import 'package:assembly/core/widgets/standar_paddings.dart';

class StandardContainer extends StatelessWidget {
  const StandardContainer({
    super.key,
    required this.child,
    this.onTap,
    this.backgroundColor,
    this.padding,
    this.isExpanded = true,
    this.borderColor,
    this.forceBorderDrawing = false,
    this.borderRadius,
  });
  final Widget child;
  final void Function()? onTap;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final bool isExpanded;
  final bool forceBorderDrawing;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isExpanded ? double.infinity : null,
      child: Material(
        borderRadius: BorderRadius.circular(
          borderRadius ?? kStandardBorderRadius,
        ),
        color:
            backgroundColor ??
            Theme.of(
              context,
            ).colorScheme.primaryContainer.withValues(alpha: .11),
        child: InkWell(
          borderRadius: BorderRadius.circular(
            borderRadius ?? kStandardBorderRadius,
          ),
          onTap: onTap,
          child: Container(
            padding: padding ?? standardPadding,
            decoration: BoxDecoration(
              border:
                  forceBorderDrawing || onTap != null
                      ? Border.all(
                        color:
                            borderColor ??
                            Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: .33),
                      )
                      : null,
              borderRadius: BorderRadius.circular(
                borderRadius ?? kStandardBorderRadius,
              ),
              color: Colors.transparent,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
