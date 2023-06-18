import 'package:flutter/material.dart';
import 'package:mathx_android/logic/tools/CalculatorLogic.dart';
import 'package:qr_flutter/qr_flutter.dart';

extension WholeNumber on num {
  bool isIntValue() => (this % 1) == 0;
}

class InlineEquationSharingView extends StatelessWidget {
  const InlineEquationSharingView({super.key, required this.equation});

  final Calculation equation;

  @override
  Widget build(BuildContext context) {
    return QrImageView(
      data: equation.base64EncodedLink,
      size: 300,
    );
  }
}
