import 'package:mathx_android/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String _dbName = 'notes.db';
  static const String _tableName = 'notes';

  DatabaseHelper._(); // Private constructor

  static final DatabaseHelper instance = DatabaseHelper._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    // Initialize the database
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = await getDatabasesPath();
    final String fullPath = join(path, _dbName);

    return await openDatabase(
      fullPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY,
            name TEXT,
            date TEXT,
            content TEXT,
            renderMath INTEGER
          )
        ''');
        await db.insert(
          _tableName,
          Note(
                  name: "LaTeX Example Note",
                  content:
                      "Welcome to MathX! This note is an example of how you can integrate LaTeX into your math notes :) \n\nFor example, here's the quadratic equation: \n \\[x=\\frac{-b\\pm\\sqrt{b^2-4ac}}{2a}\\] \n\nLaTeX allows us to do all sorts of cool things with math, ranging from simple things like \\[x^2\\] to more advanced mathematical formulas.\n\nFeel free to click the \"Edit\" button in the top right hand corner to look at the LaTeX code, or you could click on the blue \"?\" button in edit mode to learn more about LaTeX.",
                  date: DateTime.now(),
                  renderMath: true)
              .toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      },
    );
  }

  Future<void> saveNotesToPersistence(List<Note> notes) async {
    final Database db = await instance.database;
    await db.transaction((txn) async {
      await txn.delete(_tableName); // Clear the table
      for (final note in notes) {
        await txn.insert(
          _tableName,
          note.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<Note>> loadNotesFromPersistence() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return maps.map((map) => Note.fromMap(map)).toList();
  }
}
