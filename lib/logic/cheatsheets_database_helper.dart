import 'package:mathx_android/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CheatsheetsDatabaseHelper {
  static const String _dbName = 'cheatsheets.db';
  static const String _tableName = 'cheatsheets';

  CheatsheetsDatabaseHelper._(); // Private constructor

  static final CheatsheetsDatabaseHelper instance =
      CheatsheetsDatabaseHelper._();

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
            title TEXT,
            secondaryLevel TEXT,
            isComingSoon INTEGER,
            isStarred INTEGER
          )
        ''');
        await db.transaction((txn) async {
          for (final cheatsheet in [
            CheatsheetDetails(
                "Numbers and Their Operations Part 1", SecondaryLevel.one),
            CheatsheetDetails(
                "Numbers and Their Operations Part 2", SecondaryLevel.one),
            CheatsheetDetails("Percentages", SecondaryLevel.one),
            CheatsheetDetails(
                "Basic Algebra and Algebraic Manipulation", SecondaryLevel.one),
            CheatsheetDetails(
                "Linear Equations and Inequalities", SecondaryLevel.one),
            CheatsheetDetails(
                "Functions and Linear Graphs", SecondaryLevel.one),
            CheatsheetDetails("Basic Geometry", SecondaryLevel.one),
            CheatsheetDetails("Polygons", SecondaryLevel.one),
            CheatsheetDetails("Geometrical Construction", SecondaryLevel.one),
            CheatsheetDetails("Number Sequences", SecondaryLevel.one),
            CheatsheetDetails(
                "Similarity and Congruence Part 1", SecondaryLevel.two),
            CheatsheetDetails(
                "Similarity and Congruence Part 2", SecondaryLevel.two),
            CheatsheetDetails("Ratio and Proportion", SecondaryLevel.two),
            CheatsheetDetails(
                "Direct and Inverse Proportions", SecondaryLevel.two),
            CheatsheetDetails("Pythagoras Theorem", SecondaryLevel.two),
            CheatsheetDetails("Trigonometric Ratios", SecondaryLevel.two),
            CheatsheetDetails("Indices", SecondaryLevel.three),
            CheatsheetDetails("Surds", SecondaryLevel.three),
            CheatsheetDetails("Functions and Graphs", SecondaryLevel.three),
            CheatsheetDetails(
                "Quadratic Functions, Equations, and Inequalities",
                SecondaryLevel.three),
            CheatsheetDetails("Coordinate Geometry", SecondaryLevel.three),
            CheatsheetDetails(
                "Exponentials and Logarithms", SecondaryLevel.three),
            CheatsheetDetails(
                "Further Coordinate Geometry", SecondaryLevel.three),
            CheatsheetDetails("Linear Law", SecondaryLevel.three),
            CheatsheetDetails(
                "Geometrical Properties of Circles", SecondaryLevel.three),
            CheatsheetDetails(
                "Polynomials and Partial Fractions", SecondaryLevel.three),
            CheatsheetDetails("Coming Soon...", SecondaryLevel.four, true)
          ]) {
            await txn.insert(
              _tableName,
              cheatsheet.toMap(),
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
        });
      },
    );
  }

  Future<void> saveCheatsheetsToPersistence(
      List<CheatsheetDetails> cheatsheets) async {
    final Database db = await instance.database;
    await db.transaction((txn) async {
      await txn.delete(_tableName); // Clear the table
      for (final cheatsheet in cheatsheets) {
        await txn.insert(
          _tableName,
          cheatsheet.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<CheatsheetDetails>> loadCheatsheetsFromPersistence() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return maps.map((map) => CheatsheetDetails.fromMap(map)).toList();
  }
}
