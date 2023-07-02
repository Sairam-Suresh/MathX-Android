import 'package:flutter/material.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/logic/notes_database_helper.dart';
import 'package:mathx_android/screens/root/tabs/Notes/mathequationfaq.dart';
import 'package:mathx_android/widgets/textwithequations.dart';

class NotePreview extends StatefulWidget {
  const NotePreview({super.key, required this.note, required this.onChange});

  final Note note;
  final VoidCallback onChange;

  @override
  State<NotePreview> createState() => _NotePreviewState();
}

class _NotePreviewState extends State<NotePreview> {
  DateTime lastModified = DateTime.now();

  String newTitle = "";
  String newContent = "";
  bool renderMath = true;
  DateTime date = DateTime.now();
  bool loadedDatabase = false;

  final NotesDatabaseHelper databaseHelper = NotesDatabaseHelper.instance;
  List<Note> listOfNotes = [];

  Future<void> loadNotes() async {
    setState(() {
      loadedDatabase = true;
    });

    final List<Note> notes = (await databaseHelper.loadNotesFromPersistence())
      ..sort((a, b) => b.date.compareTo(a.date));
    if (mounted) {
      setState(() {
        listOfNotes = notes;
        loadedDatabase = true;
      });
    }
  }

  Future<void> saveNotes() async {
    listOfNotes.sort((a, b) => b.date.compareTo(a.date));
    await databaseHelper.saveNotesToPersistence(listOfNotes);
  }

  @override
  void initState() {
    newTitle = widget.note.name;
    newContent = widget.note.content;
    renderMath = widget.note.renderMath ?? true;
    loadNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: loadedDatabase
          ? Scaffold(
              appBar: AppBar(
                title: const Text("Note Preview"),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            newTitle,
                            style: Theme.of(context).textTheme.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SwitchListTile(
                          value: renderMath,
                          onChanged: null,
                          title: Row(
                            children: [
                              const Text(
                                "Math Rendering",
                                style: TextStyle(color: Colors.white),
                              ),
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
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, bottom: 10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: TextWithEquations(
                                  text: newContent,
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 15),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: FilledButton(
                                style: FilledButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Delete note"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.delete),
                                  ],
                                ))),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: FilledButton(
                                onPressed: () {
                                  setState(() {
                                    listOfNotes.add(Note(
                                        name: newTitle,
                                        content: newContent,
                                        date: date,
                                        renderMath: renderMath));
                                  });
                                  saveNotes().then((value) {
                                    Navigator.pop(context);
                                  });
                                  widget.onChange();
                                },
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Add note"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.add),
                                  ],
                                ))),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                ],
              ))
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
