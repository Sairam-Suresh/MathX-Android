import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mathx_android/constants.dart';

// TODO: Make notecard redirect to editor view with required data

class NoteCard extends StatelessWidget {
  NoteCard({Key? key, required this.note}) : super(key: key);

  late final Note note;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: AutoSizeText(
          note.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.chevron_right),
        subtitle: AutoSizeText(
            "${note.date.day}/${note.date.month}/${note.date.year} at ${note.date.hour}:${note.date.minute}:${note.date.second}"));
  }
}
