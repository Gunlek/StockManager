import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShiftRightFixer extends StatefulWidget {
  final Widget child;

  ShiftRightFixer({required this.child});
  @override
  State<StatefulWidget> createState() => _ShiftRightFixerState();
}

class _ShiftRightFixerState extends State<ShiftRightFixer> {
  final FocusNode focus = FocusNode(skipTraversal: true, canRequestFocus: false);
  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: focus,
      onKey: (_, RawKeyEvent event) {
        return event.physicalKey == PhysicalKeyboardKey.shiftRight ? KeyEventResult.handled : KeyEventResult.ignored;
      },
      child: widget.child,
    );
  }
}
