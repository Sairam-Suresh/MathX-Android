import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/logic/NotesDatabaseHelper.dart';
import 'package:mathx_android/logic/ShareNoteHelper.dart';
import 'package:mathx_android/widgets/notecard.dart';

import 'noteeditor.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key, this.deepLinkNote}) : super(key: key);

  final Note? deepLinkNote;

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Note> listOfNotes = [];
  final TextEditingController _searchController = TextEditingController();
  List<Widget> noteCards = [];
  bool isLoading = true;
  final NotesDatabaseHelper databaseHelper = NotesDatabaseHelper.instance;

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
    if (mounted) {
      setState(() {
        listOfNotes = notes;
        isLoading = false;
      });
    }
  }

  Future<void> saveNotes() async {
    listOfNotes.sort((a, b) => b.date.compareTo(a.date));
    await databaseHelper.saveNotesToPersistence(listOfNotes);
  }

  @override
  void didUpdateWidget(covariant NotesPage oldWidget) {
    loadNotes();
    super.didUpdateWidget(oldWidget);
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
                isInEditMode: true,
                onChange: (note) {
                  onChangeHandler(listOfNotes.length - 1, note);
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
                onShare: shareNote,
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
                          itemBuilder: (BuildContext _, int index) {
                            return listOfNotes[index]
                                    .name
                                    .contains(_searchController.text)
                                ? Slidable(
                                    endActionPane: ActionPane(
                                      motion: const DrawerMotion(),
                                      extentRatio: 0.3,
                                      children: [
                                        SlidableAction(
                                            onPressed: (_) {
                                              onDeleteHandler(index, context);
                                            },
                                            icon: Icons.delete,
                                            backgroundColor: Colors.red,
                                            label: "Delete"),
                                      ],
                                    ),
                                    startActionPane: ActionPane(
                                      motion: const DrawerMotion(),
                                      extentRatio: 0.3,
                                      children: [
                                        SlidableAction(
                                            onPressed: (_) {
                                              shareNote(listOfNotes[index]);
                                            },
                                            icon: Icons.share,
                                            backgroundColor: Colors.blue,
                                            label: "Share"),
                                      ],
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context1) =>
                                                NoteEditorPage(
                                              note: listOfNotes[index],
                                              onChange: (note) {
                                                onChangeHandler(index, note);
                                              },
                                              onDelete: (note) {
                                                onDeleteHandler(index, context);
                                              },
                                              onShare: shareNote,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: noteCards[index]),
                                    ),
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

  void onChangeHandler(int index, Note note) {
    setState(() {
      listOfNotes[index] = note;
    });
    saveNotes();
  }

  void onDeleteHandler(int index, BuildContext context) {
    Note temp = listOfNotes[index];

    setState(() {
      listOfNotes.removeAt(index);
    });

    saveNotes();
    Future.delayed(
      const Duration(milliseconds: 220),
    ).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Note ${temp.name} deleted",
          ),
          action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                listOfNotes.insert(index, temp);
                saveNotes();
              });
            },
          ),
        ),
      );
    });
  }
}
