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
    _database ??= await _initDatabase();
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
      },
    );
  }

  Future<void> saveNotesToPersistence(List<Note> notes) async {
    final Database db = await instance.database;
    await db.transaction((txn) async {
      await txn.delete(_tableName); // Clear the table
      for (final note in notes) {
        await txn.insert(_tableName, note.toMap());
      }
    });
  }

  Future<List<Note>> loadNotesFromPersistence() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return maps.map((map) => Note.fromMap(map)).toList();
  }
}
