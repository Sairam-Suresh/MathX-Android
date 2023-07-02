import 'package:mathx_android/constants.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// TODO: Fix markdown message

class NotesDatabaseHelper {
  static const String _dbName = 'notes.db';
  static const String _tableName = 'notes';

  NotesDatabaseHelper._(); // Private constructor

  static final NotesDatabaseHelper instance = NotesDatabaseHelper._();

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
                      "Welcome to MathX! This note is an example of how you can integrate LaTeX into your math notes :) \n\nFor example, here's the quadratic equation: \n \$x=\\frac{-b\\pm\\sqrt{b^2-4ac}}{2a}\$ \n\nLaTeX allows us to do all sorts of cool things with math, ranging from simple things like \$x^2\$ to more advanced mathematical formulas.\n\nFeel free to click the \"Edit\" button in the top right hand corner to look at the LaTeX code, or you could click on the blue \"?\" button in edit mode to learn more about LaTeX.",
                  date: DateTime.now(),
                  renderMath: true)
              .toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        await db.insert(
          _tableName,
          Note(
                  name: "Markdown Tutorial Note",
                  content: """# Introduction
Welcome to the **markdown tutorial**! This note is an *example* of how you can integrate the ~~markup~~ markdown function into your math notes :)

Note: Markdown text is disabled when Math Rendering is enabled

Feel free to click the \"Edit\" button in the top right hand corner to look at the markdown text

## Examples
### Quotes

You can quote text with a ">".

> This is a very inspirational quote

– MathX Team


### Code
#### Inline code
If you ever need to type `code`, you can always use backticks (\\`) to enter `inline codes!`

#### Block code
```
And block code too!
Block codes are also horizontally scrollable.
```

### Links
[Links](https://example.com) work as well!

### Lists
#### Bullet and numbered lists
If you ever need to list down anything, you can bullet or number them!

Example list 1:

1. Numbered item
2. Numbered item

Example list 2:

- Bullet item
- Bullet item

Example list 3:

* Bullet item
* Bullet item

Mixed list:
1. Numbered item
- Bullet item
- Bullet item
2. Numbered item
* Bullet item

#### Checklists
If bulleted and numbered lists aren't enough, checklists are available too!

**Homework:**

- [x] Math Workbook
- [x] ~~Slashed Item~~
- [ ] SLS

### Tables
Who doesn't like tables?

| Left Alignment | Center Alignment | Right Alignment |
|:-|:-:|-:|
| Text | Text | Text |


# Important
- If markdown does not appear or does not appear as expected, try adding a new line before/after the block markdown
- If you need to type special characters, remember to add a backslash \" \\ \" in front of it.

## Example:
\\`code\\` instead of `code`

\\### Text

instead of:
### Text""",
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
