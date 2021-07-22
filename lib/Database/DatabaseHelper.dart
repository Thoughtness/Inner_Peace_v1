import 'package:inner_peace_v1/Database/MealIngredientData.dart';
import 'package:inner_peace_v1/Database/SymptomData.dart';
import 'package:inner_peace_v1/Database/SymptomsIngredientData.dart';
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

    _database = await _initDB('mealData30.db');
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
    meal TEXT
    );""");
    // symptomsID INTEGER,
    // FOREIGN KEY(symptomsID) REFERENCES symptoms(symptomsID)
    // mealingredientID INTEGER,
    // FOREIGN KEY(mealingredientID) REFERENCES mealingredient(mealingredientID)
    await db.execute("""
    CREATE TABLE ingredient(
    ingredientID INTEGER PRIMARY KEY,
    ingredient TEXT,
    UNIQUE(ingredient)    
    )""");
    // symptomsTotalCounter REAL,
    //     flatulenceAverage REAL,
    // bowelAverage REAL,
    // generalWellbeingAverage REAL,
    // crampsAverage REAL,
    await db.execute("""
    CREATE TABLE symptoms(
    symptomsID INTEGER PRIMARY KEY,
    symptomTotal REAL,
    generalWellbeing REAL,
    cramps REAL,
    flatulence REAL,
    bowel REAL
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
    CREATE TABLE symptomsingredient(
    symptomsingredientID INTEGER PRIMARY KEY,
    symptomsID INTEGER,
    ingredientID INTEGER,
    FOREIGN KEY(symptomsID) REFERENCES symptoms(symptomsID),
    FOREIGN KEY(ingredientID) REFERENCES ingredient(ingredientID)
    );""");
  }
  //
  // getRecordedMeals(int mealID) async {
  //   final db = await database;
  //   List<Map<String, dynamic>> allMeals = await db.rawQuery(
  //       'SELECT meal.meal, symptoms.generalWellbeing, symptoms.cramps, symptoms.flatulence, symptoms.bowel FROM meal JOIN mealingredient ON meal.mealID = mealingredient.mealID JOIN ingredient ON mealingredient.ingredientID = ingredient.ingredientID JOIN symptomsingredient ON ingredient.ingredientID = symptomsingredient.ingredientID JOIN symptoms ON symptomsingredient.symptomsID = symptoms.symptomsID WHERE meal.mealID = ?', [mealID]);
  //   var allMealsWithSymptoms = allMeals.toList();
  //   return allMealsWithSymptoms;
  // }

  getRecordedMeals(int mealID) async {
    final db = await database;
    List<Map<String, dynamic>> allMeals = await db.rawQuery(
        'SELECT meal.meal, symptoms.generalWellbeing, symptoms.cramps, symptoms.flatulence, symptoms.bowel FROM meal JOIN mealingredient ON meal.mealID = mealingredient.mealID JOIN ingredient ON mealingredient.ingredientID = ingredient.ingredientID JOIN symptomsingredient ON ingredient.ingredientID = symptomsingredient.ingredientID JOIN symptoms ON symptomsingredient.symptomsID = symptoms.symptomsID WHERE meal.mealID = ?', [mealID]);
    var allMealsWithSymptoms = allMeals.toList();
    return allMealsWithSymptoms;
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

  Future<void> createSymptomsIngredient(SymptomsIngredientData symptomsIngredient) async {
    final db = await database;
    await db.insert(
      'symptomsingredient',
      symptomsIngredient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<SymptomsIngredientData>> getSymptomsIngredient() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('symptomsingredient');

    return List.generate(maps.length, (i) {
      return SymptomsIngredientData(
        symptomsID: maps[i]['symptomsID'],
        ingredientID: maps[i]['ingredientID'],
      );
    });
  }

  Future<void> insertSymptoms(SymptomData symptoms) async {
    final db = await database;
    await db.insert(
      'symptoms',
      symptoms.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  getSymptomsID() async {
    final db = await database;
    List<Map<String, dynamic>> lastInsertedSymptoms = await db.rawQuery('SELECT * FROM symptoms ORDER BY symptomsID DESC LIMIT 1');
    var symptomsID = lastInsertedSymptoms.toList();
    return symptomsID;
  }

  // Future<List> queryAll() async {
  //   Database db = await database;
  //   List<Map> names = await db.rawQuery('select Name.name, count(Date.date) from Name left join Date using(id) group by Name.name');
  //   if (names.length > 0) {
  //     return names;
  //   }
  //   return null;
  // }
  // Future<List<SymptomData>> getSymptomsID() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query('symptoms');
  //
  //   return List.generate(maps.length, (i) {
  //     return SymptomData(
  //       symptomID: maps[i]['symptomsID'],
  //       symptomTotal: maps[i]['symtpomTotal']
  //     );
  //   });
  // }

  // Future<void> updateMeal(MealData meal) async {
  //   final db = await database;
  //   await db.update(
  //     'meal',
  //     meal.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [meal.id],
  //   );
  // }

  // Future<List<MealData>> allMeals() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query('meal');
  //
  //   return List.generate(maps.length, (i) {
  //     return MealData(
  //       meal: maps[i]['meal'],
  //       mealIngredientID: maps[i][
  //           'ingredientID'], //ToDo hier muss nicht die ID sondern alle Zutaten mit der ingredientID ausgegeben werden
  //       symptomID: maps[i][
  //           'symptomID'], //ToDo hier muss nicht die ID sondern alle Zutaten mit der symptomID ausgegeben werden
  //     );
  //   });
  // }

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
