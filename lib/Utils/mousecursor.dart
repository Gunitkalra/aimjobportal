
import 'package:flutter/material.dart';

/// Wraps any widget and shows a pointer (hand) cursor on hover.
/// Works on Web, Windows, macOS, Linux — no-op on mobile (safe to use everywhere).
class PointerCursor extends StatelessWidget {
  const PointerCursor({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: child,
    );
  }
}