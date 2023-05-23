import 'package:flutter/material.dart';
import 'package:mathx_android/widgets/textfieldlist.dart';

class Tool extends StatefulWidget {
  const Tool({Key? key}) : super(key: key);

  @override
  _ToolState createState() => _ToolState();
}

class _ToolState extends State<Tool> {
  TextFieldListController controller = TextFieldListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: TextFieldList(
            limitEntries: const {"a": 1, "b": 2},
            controller: controller,
            onChange: (values) {
              print(values);
            },
          ),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() {
                controller.addNewField();
              });
            },
            child: Icon(Icons.plus_one))
      ],
    ));
  }
}
