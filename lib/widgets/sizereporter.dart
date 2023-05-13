import 'package:flutter/material.dart';

class SizeReporter extends StatelessWidget {
  final Widget child;
  final void Function(Size size) onSizeChanged;

  const SizeReporter({required this.child, required this.onSizeChanged});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size newSize = constraints.biggest;
        onSizeChanged(newSize);
        return child;
      },
    );
  }
}
