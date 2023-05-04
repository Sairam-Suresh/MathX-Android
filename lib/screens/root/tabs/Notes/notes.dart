import 'package:flutter/material.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/widgets/notecard.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  // TODO: Make this push to persistence
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
      noteCards.add(NoteCard(note: note));
    }

    // Function to help refresh Notes List in case it was updated in the add notes sheet
    void outerSetState(dynamic value) {
      setState(() {});
    }

    String name = "";
    String desc = "";
    DateTime? time;

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
                  return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
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
                              decoration: const InputDecoration(
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
                              decoration: const InputDecoration(
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
                                setState(() {
                                  time = time;
                                });

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
                                  const Text("Select Date"),
                                  Icon(
                                      time != null ? Icons.check : Icons.close),
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
                                name = "";
                                desc = "";
                                time = null;

                                setState(() {});
                                outerSetState(null);
                                Navigator.pop(context);
                              },
                              child: const Text("Save"),
                            ),
                          ),
                          const Spacer(flex: 2)
                        ],
                      ),
                    );
                  });
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
