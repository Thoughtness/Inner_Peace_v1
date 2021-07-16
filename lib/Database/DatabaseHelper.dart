import 'package:inner_peace_v1/Database/MealIngredientData.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:inner_peace_v1/Database/MealData.dart';
import 'package:inner_peace_v1/Database/IngredientData.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;
  DatabaseHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('mealData23.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final path = join(await getDatabasesPath(), filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute("""
    CREATE TABLE meal(
    mealID INTEGER PRIMARY KEY,
    meal TEXT,
    symptomsID INTEGER,
    mealingredientID INTEGER,
    FOREIGN KEY(symptomsID) REFERENCES symptoms(symptomsID)
    FOREIGN KEY(mealingredientID) REFERENCES mealingredient(mealingredientID)
    );""");
    await db.execute("""
    CREATE TABLE mealingredient(
    mealingredientID INTEGER PRIMARY KEY,
    mealID INTEGER,
    ingredientID INTEGER,
    FOREIGN KEY(mealID) REFERENCES meal(mealID),
    FOREIGN KEY(ingredientID) REFERENCES ingredient(ingredientID)
    );""");
    await db.execute("""
    CREATE TABLE ingredient(
    ingredientID INTEGER PRIMARY KEY,
    ingredient TEXT,
    symptomsTotalCounter REAL,
    flatulenceAverage REAL,
    bowelAverage REAL,
    generalWellbeingAverage REAL,
    crampsAverage REAL,
    UNIQUE(ingredient)    
    )""");
    await db.execute("""
    CREATE TABLE symptoms(
    symptomsID INTEGER PRIMARY KEY,
    symptomTotal REAL,
    generalWellbeing REAL,
    cramps REAL,
    flatulence REAL,
    bowel REAL
    );""");
    // await db.execute(
    //     'CREATE TABLE meal (id INTEGER PRIMARY KEY AUTOINCREMENT, meal TEXT, symptomID INTEGER, ingredientID INTEGER, FOREIGN KEY(symptomID) REFERENCES symptoms(symptomID) FOREIGN KEY(ingredientID) REFERENCES ingredient(ingredientID))');
    // await db.execute(
    //     'CREATE TABLE symptoms (symptomID INTEGER PRIMARY KEY, symptomTotal REAL, generalWellbeing REAL, cramps REAL, flatulence REAL, bowel REAL);""");
  }

  Future<void> insertMeal(MealData meal) async {
    final db = await database;
    await db.insert(
      'meal',
      meal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  getMealID() async {
    final db = await database;
    List<Map<String, dynamic>> lastInsertedMeal = await db.rawQuery('SELECT * FROM meal ORDER BY mealID DESC LIMIT 1');
    var mealID = lastInsertedMeal.toList();
    return mealID;
  }


  Future<void> insertIngredient(IngredientData ingredient) async {
    final db = await database;
    await db.insert(
      'ingredient',
      ingredient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<IngredientData>> getIngredientID() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('ingredient');

    return List.generate(maps.length, (i) {
      return IngredientData(
        ingredientID: maps[i]['ingredientID'],
        ingredient: maps[i]['ingredient'],
      );
    });
  }

  Future<void> createMealIngredient(MealIngredientData mealIngredient) async {
    final db = await database;
    await db.insert(
      'mealingredient',
      mealIngredient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<MealIngredientData>> getMealIngredient() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('mealingredient');

    return List.generate(maps.length, (i) {
      return MealIngredientData(
        mealID: maps[i]['mealID'],
        ingredientID: maps[i]['ingredientID'],
      );
    });
  }

  // Future<void> updateMeal(MealData meal) async {
  //   final db = await database;
  //   await db.update(
  //     'meal',
  //     meal.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [meal.id],
  //   );
  // }

  Future<List<MealData>> allMeals() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('meal');

    return List.generate(maps.length, (i) {
      return MealData(
        meal: maps[i]['meal'],
        mealIngredientID: maps[i][
            'ingredientID'], //ToDo hier muss nicht die ID sondern alle Zutaten mit der ingredientID ausgegeben werden
        symptomID: maps[i][
            'symptomID'], //ToDo hier muss nicht die ID sondern alle Zutaten mit der symptomID ausgegeben werden
      );
    });
  }

  Future<List<IngredientData>> allIngredients() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('ingredient');

    return List.generate(maps.length, (i) {
      return IngredientData(
        ingredient: maps[i]['ingredient'],
      );
    });
  }

  Future<void> deleteMeal(int id) async {
    final db = await database;
    await db.delete(
      'meal',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Future<MealData> getProductById(int id) async {
  //   final db = await database;
  //   var result = await db.query("Product", where: "id = ", whereArgs: [id]);
  //   return result.isNotEmpty ? MealData.toMap(result.first) : Null;
  // }

  //var maxIdResult = await db.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM Product");
  //var id = maxIdResult.first["last_inserted_id"];
}
