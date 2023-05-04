import 'package:flutter/material.dart';
import 'package:mathx_android/constants.dart';
import 'package:mathx_android/widgets/notecard.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        children: [NoteCard(name: "Note 1"), NoteCard(name: "Note 1")],
      ),
    );
  }
}
