import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:mathx_android/widgets/textfieldlist.dart';

class Tool extends StatefulWidget {
  Tool({Key? key, this.displayOptions, this.innerTabs, this.tabs})
      : super(key: key);

  late List<Widget>? displayOptions;
  late Map<String, Widget>? tabs;
  late Map<String, Widget>? innerTabs;

  @override
  _ToolState createState() => _ToolState();
}

class _ToolState extends State<Tool> {
  TextFieldListController controller = TextFieldListController();
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return widget.displayOptions != null && widget.tabs != null
        ? DefaultTabController(
            length: widget.tabs!.values.toList().length,
            child: Scaffold(
              appBar: AppBar(
                title: Text("amongs"),
                bottom: TabBar(
                  tabs: widget.tabs!.keys
                      .map((key) => Tab(
                            child: widget.tabs![key],
                          ))
                      .toList(),
                ),
              ),
              body: TabBarView(children: [
                Column(
                  children: [
                    TextFieldList(
                      limitEntries: const {"a": 1, "b": 2},
                      controller: controller,
                      onChange: (values) {
                        print(values);
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            controller.addNewField();
                          });
                        },
                        child: const Icon(Icons.plus_one))
                  ],
                ),
                Column(
                  children: [
                    TextFieldList(
                      limitEntries: const {"a": 1, "b": 2},
                      controller: controller,
                      onChange: (values) {
                        print(values);
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            controller.addNewField();
                          });
                        },
                        child: const Icon(Icons.plus_one))
                  ],
                ),
              ]),
            ))
        : const Scaffold(
            body: Text("am"),
          );
  }
}
