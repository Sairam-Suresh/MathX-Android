import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:path_provider/path_provider.dart';

// INFO: This function will be executed when the Notes database is also created, in notes_database_helper.dart
// This is because the database will also be initialised only once when the app starts and is
// a perfect opportunity to extract the cheatsheet resources

// The cheatsheets are extracted to APPLICATION_DOCUMENTS_DIRECTORY/cheatsheets/

Future<void> extractCheatsheets() async {
  try {
    final asset = await rootBundle.load('assets/pdfs.zip');
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/cheatsheets.zip');
    await file.writeAsBytes(asset.buffer.asUint8List());

    await ZipFile.extractToDirectory(
        zipFile: file,
        destinationDir: Directory(
            '${(await getApplicationDocumentsDirectory()).path}/cheatsheets/'));

    await file.delete(); // Remove file once completed
  } catch (error) {
    debugPrint('Error loading binary file: $error');
  }
}
