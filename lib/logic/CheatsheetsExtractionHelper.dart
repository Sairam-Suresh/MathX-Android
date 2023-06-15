import 'package:archive/archive_io.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

// INFO: This function will be executed when the Notes database is also created, in NotesDatabaseHelper.dart
// This is because the database will also be initialised only once when the app starts and is
// a perfect opportunity to extract the cheatsheet resources

// The cheatsheets are extracted to APPLICATION_DOCUMENTS_DIRECTORY/cheatsheets/

Future<void> extractCheatsheets() async {
  try {
    final byteData = await rootBundle.load('assets/pdfs.zip');
    final bytes = byteData.buffer.asUint8List();
    final archive = ZipDecoder().decodeBytes(bytes);
    extractArchiveToDisk(archive,
        "${(await getApplicationDocumentsDirectory()).toString().replaceAll("Directory: '", "").replaceAll("'", "")}/cheatsheets/");
    debugPrint(
        "${(await getApplicationDocumentsDirectory()).toString().replaceAll("Directory: '", "").replaceAll("'", "")}/cheatsheets/");
    // Process the byteData as needed
  } catch (error) {
    debugPrint('Error loading binary file: $error');
  }
}
