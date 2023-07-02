import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/screens/root/tabs/Notes/mathequationfaq.dart';
import 'package:mathx_android/widgets/custommarkdownbody.dart';
import 'package:mathx_android/widgets/textwithequations.dart';

class NoteEditorPage extends StatefulWidget {
  const NoteEditorPage({
    Key? key,
    required this.note,
    this.isInEditMode,
    required this.onChange,
    required this.onDelete,
    required this.onShare,
  }) : super(key: key);

  final Note note;
  final bool? isInEditMode;
  final void Function(Note note) onChange;
  final void Function(Note note) onDelete;
  final void Function(Note note) onShare;

  @override
  _NoteEditorPageState createState() => _NoteEditorPageState();
}

class _NoteEditorPageState extends State<NoteEditorPage> {
  bool isEditMode = false;

  TextEditingController titleEditingController = TextEditingController();
  TextEditingController contentEditingController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();

  DateTime lastModified = DateTime.now();
  String newTitle = "";
  String newContent = "";
  bool renderMath = true;

  @override
  void initState() {
    super.initState();
    contentFocusNode.requestFocus();
    setState(() {
      isEditMode = widget.isInEditMode ?? false;

      newTitle = widget.note.name;
      newContent = widget.note.content;
      renderMath = widget.note.renderMath ?? true;
      lastModified = widget.note.date;
      titleEditingController = TextEditingController(text: widget.note.name);
      contentEditingController =
          TextEditingController(text: widget.note.content);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            pinned: true,
            centerTitle: true,
            title: isEditMode
                ? IntrinsicWidth(
                    child: EditableText(
                      textAlign: TextAlign.center,
                      readOnly: !isEditMode,
                      controller: titleEditingController,
                      cursorColor: isDarkMode ? Colors.white : Colors.black,
                      focusNode: titleFocusNode,
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontSize: 20),
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

                        lastModified = DateTime.now();

                        widget.onChange(
                          Note(
                            name: newTitle,
                            content: newContent,
                            date: lastModified,
                            renderMath: renderMath,
                          ),
                        );
                      },
                      backgroundCursorColor: Colors.white,
                    ),
                  )
                : Text(
                    newTitle,
                    style: const TextStyle(fontSize: 20),
                  ),
            actions: isEditMode
                ? [
                    IconButton(
                      onPressed: () {
                        setState(
                          () {
                            Navigator.pop(context);
                            widget.onDelete(widget.note);
                          },
                        );
                      },
                      icon: const Icon(Icons.delete),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (titleFocusNode.hasFocus) {
                            FocusScope.of(context).requestFocus(FocusNode());
                            lastModified = DateTime.now();

                            widget.onChange(
                              Note(
                                name: newTitle,
                                content: newContent,
                                date: lastModified,
                                renderMath: renderMath,
                              ),
                            );
                          } else {
                            isEditMode = false;
                            lastModified = DateTime.now();
                            widget.onChange(
                              Note(
                                name: newTitle,
                                content: newContent,
                                date: lastModified,
                                renderMath: renderMath,
                              ),
                            );
                          }
                        });
                      },
                      icon: const Icon(Icons.check),
                    ),
                  ]
                : [
                    IconButton(
                        onPressed: () {
                          widget.onShare(Note(
                            name: newTitle,
                            content: newContent,
                            date: lastModified,
                            renderMath: renderMath,
                          ));
                        },
                        icon: const Icon(Icons.share))
                  ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isEditMode
                      ? Column(
                          children: [
                            SwitchListTile(
                              value: renderMath,
                              onChanged: (value) {
                                setState(() {
                                  renderMath = value;
                                });
                                lastModified = DateTime.now();

                                widget.onChange(
                                  Note(
                                    name: newTitle,
                                    content: newContent,
                                    date: lastModified,
                                    renderMath: renderMath,
                                  ),
                                );
                              },
                              title: Row(
                                children: [
                                  const Text("Math Rendering"),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const MathEquationFAQ(),
                                              fullscreenDialog: true));
                                    },
                                    icon: const Icon(Icons.question_mark),
                                    iconSize: 20,
                                    color: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: const Text("Last Modified"),
                              trailing: AutoSizeText(
                                "${lastModified.day.toString().padLeft(2, '0')}/${lastModified.month.toString().padLeft(2, '0')}/${lastModified.year.toString().padLeft(2, '0')} at ${lastModified.hour.toString().padLeft(2, '0')}:${lastModified.minute.toString().padLeft(2, '0')}:${lastModified.second.toString().padLeft(2, '0')}",
                                minFontSize: 15,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        )
                      : Container(),
                  !isEditMode
                      ? renderMath
                          ? TextWithEquations(text: newContent)
                          : buildMarkdownBody(
                              newContent,
                              Theme.of(context).brightness == Brightness.dark,
                              renderMath)
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                            controller: contentEditingController,
                            focusNode: contentFocusNode,
                            maxLines: null,
                            onChanged: (value) {
                              setState(() {
                                newContent = value;
                                lastModified = DateTime.now();
                              });
                            },
                            style: const TextStyle(),
                            cursorColor:
                                isDarkMode ? Colors.white : Colors.black,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: !isEditMode
          ? FloatingActionButton(
              child: const Icon(Icons.edit),
              onPressed: () {
                setState(() {
                  isEditMode = true;
                });
              },
            )
          : null,
    );
  }
}
