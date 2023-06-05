import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' as widgets;
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/widgets/textwithequations.dart';

class NoteEditorPage extends StatefulWidget {
  NoteEditorPage(
      {Key? key,
      required this.note,
      this.isinEditMode,
      required this.onChange,
      required this.onDelete})
      : super(key: key);

  late Note note;
  late void Function(Note note) onChange;
  late void Function(Note note) onDelete;
  late bool? isinEditMode;

  @override
  _NoteEditorPageState createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  bool isEditMode = false;

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController contentEditingController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();

  String newTitle = "";
  String newContent = "";
  bool renderMath = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      isEditMode = widget.isinEditMode ?? false;

      newTitle = widget.note.name;
      newContent = widget.note.content;
      renderMath = widget.note.renderMath ?? true;
      titleEditingController = TextEditingController(text: widget.note.name);
      contentEditingController =
          TextEditingController(text: widget.note.content);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: IntrinsicWidth(
            child: widgets.EditableText(
              textAlign: TextAlign.center,
              readOnly: !isEditMode,
              backgroundCursorColor: Colors.white,
              controller: titleEditingController,
              cursorColor: Colors.white,
              focusNode: titleFocusNode,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              onChanged: (value) {
                setState(() {
                  newTitle = value;
                });
              },
              onTapOutside: (_) {
                titleFocusNode.unfocus();
              },
              onSubmitted: (value) {
                setState(() {
                  newTitle = value;
                });
                widget.onChange(Note(
                    name: newTitle,
                    content: newContent,
                    date: DateTime.now(),
                    renderMath: renderMath));
              },
            ),
          ),
          actions: isEditMode
              ? [
                  IconButton(
                      onPressed: () {
                        print(titleFocusNode.hasFocus);
                        setState(
                          () {
                            Navigator.pop(context);
                            widget.onDelete(widget.note);
                          },
                        );
                      },
                      icon: const Icon(Icons.delete)),
                  IconButton(
                    onPressed: () {
                      print(titleFocusNode.hasFocus);
                      setState(() {
                        if (titleFocusNode.hasFocus) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          widget.onChange(Note(
                              name: newTitle,
                              content: newContent,
                              date: DateTime.now(),
                              renderMath: renderMath));
                        } else {
                          isEditMode = false;
                          widget.onChange(Note(
                              name: newTitle,
                              content: newContent,
                              date: DateTime.now(),
                              renderMath: renderMath));
                        }
                      });
                    },
                    icon: const Icon(Icons.check),
                  )
                ]
              : [],
        ),
        floatingActionButton: buildFloatingActionButton(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isEditMode
                  ? SwitchListTile(
                      value: renderMath ?? true,
                      onChanged: (value) {
                        setState(() {
                          renderMath = value;
                          print(renderMath);
                        });
                        widget.onChange(Note(
                            name: newTitle,
                            content: newContent,
                            date: DateTime.now(),
                            renderMath: renderMath));
                      },
                      title: Row(
                        children: [
                          const Text("Math Rendering"),
                          IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return MathEquationFAQ();
                                  });
                            },
                            icon: const Icon(Icons.question_mark),
                            iconSize: 20,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    )
                  : Container(),
              !isEditMode
                  ? renderMath
                      ? TextWithEquations(text: newContent)
                      : Text(newContent)
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: EditableText(
                          controller: contentEditingController,
                          focusNode: contentFocusNode,
                          maxLines: 9007199254740991,
                          onChanged: (value) {
                            setState(() {
                              newContent = value;
                            });
                          },
                          onTapOutside: (_) {
                            contentFocusNode.unfocus();
                          },
                          style: const TextStyle(),
                          cursorColor: Colors.white,
                          backgroundCursorColor: Colors.white,
                        ),
                      ),
                    ),
            ],
          ),
        ));
  }

  FloatingActionButton? buildFloatingActionButton() {
    return !isEditMode
        ? FloatingActionButton(
            child: const Icon(Icons.edit),
            onPressed: () {
              setState(() {
                isEditMode = true;
              });
            })
        : null;
  }
}

class MathEquationFAQ extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Rendering FAQ'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ExpansionTile(
            title: const Text('What is Math Rendering?'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.5),
                child: TextWithEquations(
                  text:
                      'Math Rendering allows you to input mathematical equations using LaTeX. Example: \\[x=\\frac{1}{2}\\]',
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('How do you type LaTeX equations?'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.5),
                child: Column(
                  children: [
                    const Text(
                      'You can start LaTeX equations using \\[ and end it with \\]. Example: \\[x=\\frac{1}{2}\\]',
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Expanded(child: Text('\\[\\frac{1}{2}\\]')),
                        TextWithEquations(text: '\\[\\frac{1}{2}\\]'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          ExpansionTile(
            title: const Text('What are some examples of LaTeX?'),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                            child: Text('Indices/Index - \\[4^7\\]')),
                        TextWithEquations(text: '\\[4^7\\]'),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Expanded(
                            child: Text('Fractions - \\[\\frac{3}{7}\\]')),
                        TextWithEquations(text: '\\[\\frac{3}{7}\\]'),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Square root -\n\\[x=\\pm\\sqrt[4]{b^2-4ac}\\]',
                          ),
                        ),
                        TextWithEquations(
                            text: '\\[x=\\pm\\sqrt[4]{b^2-4ac}\\]'),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'You can also search online for more LaTeX functions.',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const ExpansionTile(
            title: Text('What if I don\'t want to use Math Rendering?'),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 7.5),
                child: Text(
                  'Your texts will be rendered in plain text and appear as normal characters. You can always choose to enable/disable Math Rendering later on.',
                ),
              ),
            ],
          ),
          const ExpansionTile(
            title: Text(
                'Why can\'t I edit my notes when Math Rendering is enabled?'),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 7.5),
                child: Text(
                  'To edit your notes when Math Rendering is enabled, press the "Edit" button in the top right hand corner of your note. Non-Math Rendering notes can be edited without needing to click on the "Edit" button.',
                ),
              ),
            ],
          ),
          const ExpansionTile(
            title: Text(
                'Why won\'t my texts leave a line when Math Rendering is enabled?'),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 7.5),
                child: Text(
                  'Leave a line when Math Rendering is enabled:\n\nIf your line ends with a LaTeX equation, add a space at the end of your line. Example: "\\[x=\\frac{2}{5}\\] "\n\nIf your line starts with a LaTeX equation, add a space at the start of your line. Example: " \\[x=\\frac{2}{5}\\]"',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
