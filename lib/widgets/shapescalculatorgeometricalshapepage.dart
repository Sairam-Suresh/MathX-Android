import 'package:flutter/material.dart';
import 'package:mathx_android/widgets/fixedtextfieldlist.dart';

class GeometricalShapeTab extends StatefulWidget {
  const GeometricalShapeTab(
      {super.key, required this.entries, required this.builder});

  final List<String> entries;
  final Widget Function(List<String?> values, bool isValid) builder;

  @override
  State<GeometricalShapeTab> createState() => _GeometricalShapeTabState();
}

class _GeometricalShapeTabState extends State<GeometricalShapeTab> {
  List<String?> values = ["", ""];
  bool isFormValid = false;

  @override
  void initState() {
    setState(() {
      values = widget.entries.map((e) => "").toList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(children: [
        widget.builder(values, isFormValid),
        FixedTextFieldList(
          entries: widget.entries,
          onChange: (newValue, isValid) {
            setState(() {
              values = newValue;
              isFormValid = isValid;
            });
          },
        )
      ]),
    );
  }
}
