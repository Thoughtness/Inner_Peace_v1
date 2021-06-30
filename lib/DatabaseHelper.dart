import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:inner_peace_v1/mealData.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('quotesss.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final path = join(await getDatabasesPath(), filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute("""
    CREATE TABLE meal(
    id INTEGER PRIMARY KEY,
    meal TEXT,
    ingredients TEXT,
    symptomTotal REAL,
    generalWellbeing REAL,
    cramps REAL,
    flatulence REAL,
    bowel 
    );""");
  }

  Future<void> insertMeal(mealData meal) async {
    final db = await database;
    await db.insert(
      'meal',
      meal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<mealData>> meals() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('meal');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return mealData(
        id: maps[i]['id'],
        meal: maps[i]['meal'],
        ingredients: maps[i]['ingredients'],
      );
    });
  }
}
