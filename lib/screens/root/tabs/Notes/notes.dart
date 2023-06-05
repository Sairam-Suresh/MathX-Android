import 'package:flutter/material.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/logic/NotesDatabaseHelper.dart';
import 'package:mathx_android/widgets/notecard.dart';

import 'noteeditor.dart';

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
        date: DateTime.now(),
        content: r"Content 1 \frac{1}{2}"),
    Note(name: "Note 2", date: DateTime.now(), content: "Content 2")
  ];

  TextEditingController searchController = TextEditingController();

  List<Widget> noteCards = [];
  final DatabaseHelper databaseHelper = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    final List<Note> notes = await databaseHelper.loadNotesFromPersistence();
    setState(() {
      listOfNotes = notes;
    });
  }

  Future<void> saveNotes() async {
    await databaseHelper.saveNotesToPersistence(listOfNotes);
  }

  @override
  Widget build(BuildContext context) {
    noteCards = [];
    for (Note note in listOfNotes) {
      noteCards.add(NoteCard(note: note));
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            listOfNotes.add(Note(
              content: "",
              name: "New Note",
              date: DateTime.now(),
            ));
            Navigator.push(context, MaterialPageRoute(builder: (context1) {
              return NoteEditorPage(
                note: listOfNotes.last,
                isinEditMode: true,
                onChange: (note) {
                  setState(() {
                    listOfNotes[listOfNotes.length - 1] = note;
                  });
                  saveNotes();
                },
                onDelete: (Note note) {
                  Note temp = listOfNotes.last;

                  setState(() {
                    listOfNotes.remove(listOfNotes.last);
                  });
                  saveNotes();
                  Future.delayed(Duration(milliseconds: 220)).then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "Note ${temp.name} deleted",
                      ),
                      action: SnackBarAction(
                          label: "Undo",
                          onPressed: () {
                            setState(() {
                              listOfNotes.add(temp);
                              saveNotes();
                            });
                          }),
                    ));
                  });
                },
              );
            }));
          });
        },
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SearchBar(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                hintText: "Search Notes",
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.symmetric(horizontal: 15)),
                leading: const Icon(Icons.search),
              ),
            ),
            Expanded(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: listOfNotes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return listOfNotes[index]
                            .name
                            .contains(searchController.text)
                        ? InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context1) => NoteEditorPage(
                                        note: listOfNotes[index],
                                        onChange: (note) {
                                          setState(() {
                                            listOfNotes[index] = note;
                                          });
                                          saveNotes();
                                        },
                                        onDelete: (note) {
                                          setState(() {
                                            listOfNotes.removeAt(index);
                                          });

                                          Note temp = note;
                                          saveNotes();

                                          setState(() {
                                            listOfNotes.remove(note);
                                          });
                                          Future.delayed(
                                                  Duration(milliseconds: 220))
                                              .then((_) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                      "Note ${temp.name} deleted",
                                                    ),
                                                    action: SnackBarAction(
                                                        label: "Undo",
                                                        onPressed: () {
                                                          setState(() {
                                                            listOfNotes.insert(
                                                                index, temp);
                                                            saveNotes();
                                                          });
                                                        })));
                                          });
                                        },
                                      )));
                            },
                            child: noteCards[index])
                        : Container();
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return listOfNotes[index]
                            .name
                            .contains(searchController.text)
                        ? Divider()
                        : Container();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
