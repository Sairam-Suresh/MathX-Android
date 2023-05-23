import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/logic/tools/RandomiserLogic.dart';
import 'package:mathx_android/widgets/tooltemplate.dart';

class RandomiserPage extends StatefulWidget {
  const RandomiserPage({Key? key}) : super(key: key);

  @override
  State<RandomiserPage> createState() => _RandomiserPageState();
}

class _RandomiserPageState extends State<RandomiserPage> {
  RandomiserData randomiserData = RandomiserData();
  int? newValue;
  RandomiserPages page = RandomiserPages.occurences;
  final _formKey = GlobalKey<FormBuilderState>();

  final FocusNode _textFieldFocusNodeMin = FocusNode();
  final FocusNode _textFieldFocusNodeMax = FocusNode();

  int? min = 0;
  int? max = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _textFieldFocusNodeMin.dispose();
    _textFieldFocusNodeMax.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Tool();
  }
}
