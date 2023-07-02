import 'package:flutter/material.dart';
import 'package:mathx_android/logic/tools/calculator_logic.dart';
import 'package:qr_flutter/qr_flutter.dart';

extension WholeNumber on num {
  bool isIntValue() => (this % 1) == 0;
}

class InlineEquationSharingView extends StatelessWidget {
  const InlineEquationSharingView({super.key, required this.equation});

  final Calculation equation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        QrImageView(
          backgroundColor: Colors.white,
          data: equation.base64EncodedLink,
        ),
        Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "[AC]: Go Back",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
              Text(
                "[DEL]: Copy to Clipboard",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
              ),
              Row(
                children: [
                  Text(
                    "[",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  Icon(
                    Icons.share,
                    size: Theme.of(context).textTheme.bodyLarge?.fontSize,
                    color: Colors.white,
                  ),
                  Text(
                    "]: Open Share Dialog",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  )
                ],
              )
            ])
      ],
    );
  }
}
