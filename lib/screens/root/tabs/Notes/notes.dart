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
    for (Note note in listOfNotes) {
      noteCards.add(NoteCard(name: note.name));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
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
