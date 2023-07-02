import 'package:mathx_android/logic/tools/calculator_logic.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class CalculationDatabaseHelper {
  static const String _dbName = 'calculations.db';
  static const String _tableName = 'calculations';

  CalculationDatabaseHelper._(); // Private constructor

  static final CalculationDatabaseHelper instance =
      CalculationDatabaseHelper._();

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
            expression TEXT,
            result REAL,
            answerBefore REAL
          )
        ''');
      },
    );
  }

  Future<void> saveCalculations(List<Calculation> calculations) async {
    final Database db = await instance.database;
    await db.transaction((txn) async {
      await txn.delete(_tableName); // Clear the table
      for (final calculation in calculations) {
        await txn.insert(
          _tableName,
          calculation.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
    });
  }

  Future<List<Calculation>> loadCalculations() async {
    final Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    return maps.map((map) => Calculation.fromMap(map)).toList();
  }
}
