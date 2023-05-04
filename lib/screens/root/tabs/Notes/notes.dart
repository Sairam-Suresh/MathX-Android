import 'package:flutter/material.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/widgets/notecard.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> listOfNotes = [
    Note(
        name: "Note 1",
        description: "Description 1",
        date: DateTime.now(),
        content: "Content 1"),
    Note(
        name: "Note 2",
        description: "Description 2",
        date: DateTime.now(),
        content: "Content 2")
  ];

  List<Widget> noteCards = [];

  @override
  Widget build(BuildContext context) {
    noteCards = [];
    for (Note note in listOfNotes) {
      noteCards.add(NoteCard(
        name: note.name,
        time: note.date,
      ));
    }

    String name = "";
    String desc = "";
    DateTime? time;

    _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(), // Refer step 1
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
      );
      if (picked != null) {
        setState(() {
          time = picked;
        });
        return picked;
      }
    }

    void rebuildAllChildren(BuildContext context) {
      void rebuild(Element el) {
        el.markNeedsBuild();
        el.visitChildren(rebuild);
      }

      (context as Element).visitChildren(rebuild);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return BottomSheet(
                builder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Create New Note',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 30),
                        ),
                        const Spacer(),
                        TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Note Name",
                            ),
                            onChanged: (value) {
                              setState(() {
                                name = value;
                              });
                            }),
                        const Spacer(),
                        TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Description",
                            ),
                            onChanged: (value) {
                              setState(() {
                                desc = value;
                              });
                            }),
                        const Spacer(),
                        Center(
                          child: FilledButton(
                            onPressed: () async {
                              time = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(), // Refer step 1
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2025),
                              );

                              setState(() {});
                              setState(() {});
                              // _selectDate(context).then((value) {
                              //   if (value != null) {
                              //     setState(() {
                              //       time = value;
                              //     });
                              //   }
                              // }).whenomplete(() {
                              //   setState(() {});
                              // });
                              // setState(() {
                              //
                              // });
                              //
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Select Date" + time.toString()),
                                Icon(time != null ? Icons.check : Icons.close),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(flex: 6),
                        Center(
                          child: FilledButton(
                            onPressed: () {
                              setState(() {
                                listOfNotes.add(Note(
                                  name: name,
                                  description: desc,
                                  date: time!,
                                  content: "",
                                ));
                              });
                              Navigator.pop(context);
                            },
                            child: const Text("Save"),
                          ),
                        ),
                        const Spacer(flex: 2)
                      ],
                    ),
                  );
                },
                onClosing: () {},
                enableDrag: false,
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        padding: EdgeInsets.all(PADDING_BETWEEN_SQUARES),
        children: noteCards,
      ),
    );
  }
}
