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
  List<Note> listOfNotes = [];
  TextEditingController _searchController = TextEditingController();
  List<Widget> noteCards = [];
  final NotesDatabaseHelper databaseHelper = NotesDatabaseHelper.instance;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadNotes();
  }

  Future<void> loadNotes() async {
    setState(() {
      isLoading = true;
    });

    final List<Note> notes = (await databaseHelper.loadNotesFromPersistence())
      ..sort((a, b) => b.date.compareTo(a.date));
    setState(() {
      listOfNotes = notes;
      isLoading = false;
    });
  }

  Future<void> saveNotes() async {
    listOfNotes.sort((a, b) => b.date.compareTo(a.date));
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
                  Future.delayed(const Duration(milliseconds: 220)).then((_) {
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
                controller: _searchController,
                onChanged: (value) {
                  setState(() {});
                },
                hintText: "Search Notes",
                padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.symmetric(horizontal: 15),
                ),
                leading: const Icon(Icons.search),
                trailing: [
                  if (_searchController.value.text != "")
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _searchController.clear();
                        });
                      },
                      icon: const Icon(Icons.delete),
                    )
                ],
              ),
            ),
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : listOfNotes.isNotEmpty
                      ? ListView.separated(
                          shrinkWrap: true,
                          itemCount: listOfNotes.length,
                          itemBuilder: (BuildContext context, int index) {
                            return listOfNotes[index]
                                    .name
                                    .contains(_searchController.text)
                                ? InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
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
                                                const Duration(
                                                    milliseconds: 220),
                                              ).then((_) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
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
                                                      },
                                                    ),
                                                  ),
                                                );
                                              });
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: noteCards[index]),
                                  )
                                : Container();
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return listOfNotes[index]
                                    .name
                                    .contains(_searchController.text)
                                ? const Divider()
                                : Container();
                          },
                        )
                      : Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Hmmmm...",
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                const Text(
                                  "You do not seem to have any notes. Create a new one using the button below.",
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
