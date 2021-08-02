import 'package:inner_peace_v1/Database/MealIngredientData.dart';
import 'package:inner_peace_v1/Database/SymptomData.dart';
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

    _database = await _initDB('mealData52.db');
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
    symptomsID INTEGER,
    meal TEXT,
    FOREIGN KEY(symptomsID) REFERENCES symptoms(symptomsID)
    );""");
    await db.execute("""
    CREATE TABLE ingredient(
    ingredientID INTEGER PRIMARY KEY,
    ingredient TEXT,
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
    await db.execute("""
    CREATE TABLE mealingredient(
    mealingredientID INTEGER PRIMARY KEY,
    mealID INTEGER,
    ingredientID INTEGER,
    FOREIGN KEY(mealID) REFERENCES meal(mealID),
    FOREIGN KEY(ingredientID) REFERENCES ingredient(ingredientID)
    );""");
  }

  getHighestMealID() async {
    final db = await database;
    List<Map<String, dynamic>> lastInsertedMeal =
        await db.rawQuery(
            """SELECT * FROM meal 
        ORDER BY mealID DESC 
        LIMIT 1""");
    var mealID = lastInsertedMeal.toList();
    return mealID;
  }

  getSymptomlessMeals() async {
    final db = await database;
    List<Map<String, dynamic>> _symptomlessMeals =
    await db.rawQuery(
        """SELECT * FROM meal
        WHERE symptomsID IS NULL""");
    var symptomlessMeals = _symptomlessMeals.toList();
    print(symptomlessMeals);
    return symptomlessMeals;
  }

  getSymptomsID() async {
    final db = await database;
    List<Map<String, dynamic>> lastInsertedMeal =
    await db.rawQuery("""SELECT symptoms.symptomsID
    FROM symptoms
    """);
    var mealID = lastInsertedMeal.toList();
    return mealID;
  }

  getAllRecordedMeals(int mealID) async {
    final db = await database;
    List<Map<String, dynamic>> allMeals = await db.rawQuery(
        """SELECT meal.mealID, meal.meal, symptoms.generalWellbeing, symptoms.cramps, symptoms.flatulence, symptoms.bowel, symptoms.symptomTotal
        FROM meal 
        JOIN mealingredient ON meal.mealID = mealingredient.mealID 
        JOIN ingredient ON mealingredient.ingredientID = ingredient.ingredientID 
        JOIN symptoms ON meal.symptomsID = symptoms.symptomsID 
        WHERE meal.mealID = ?""", [mealID]);
    var allMealsWithSymptoms = allMeals.toList();

    return allMealsWithSymptoms;
  }

  getMeal() async {
    final db = await database;
    List<Map<String, dynamic>> allMeals = await db.query('meal');

    var fdgjskkdgf = allMeals.toList();
    return fdgjskkdgf;
  }

  getCertainRecordedMeals(
      int mealID, double filterNumberLow, double filterNumberHigh) async {
    final db = await database;
    List<Map<String, dynamic>> allMeals = await db.rawQuery(
        """SELECT meal.mealID, meal.meal, symptoms.generalWellbeing, symptoms.cramps, symptoms.flatulence, symptoms.bowel, symptoms.symptomTotal
        FROM meal 
        JOIN mealingredient ON meal.mealID = mealingredient.mealID 
        JOIN ingredient ON mealingredient.ingredientID = ingredient.ingredientID 
        JOIN symptoms ON meal.symptomsID = symptoms.symptomsID 
        WHERE meal.mealID = ?
        AND symptoms.generalWellbeing BETWEEN ? and ?
        AND symptoms.cramps BETWEEN ? and ?
        AND symptoms.flatulence BETWEEN ? and ?
        AND symptoms.bowel BETWEEN ? and ?""",
        [
          mealID,
          filterNumberLow,
          filterNumberHigh,
          filterNumberLow,
          filterNumberHigh,
          filterNumberLow,
          filterNumberHigh,
          filterNumberLow,
          filterNumberHigh
        ]);
    var allMealsWithSymptoms = allMeals.toList();
    return allMealsWithSymptoms;
  }

  getIntolerantRecordedMeals(int mealID, double filterNumberLow) async {
    final db = await database;
    List<Map<String, dynamic>> allMeals = await db.rawQuery(
        """SELECT meal.mealID, meal.meal, symptoms.generalWellbeing, symptoms.cramps, symptoms.flatulence, symptoms.bowel, symptoms.symptomTotal
        FROM meal 
        JOIN mealingredient ON meal.mealID = mealingredient.mealID 
        JOIN ingredient ON mealingredient.ingredientID = ingredient.ingredientID 
        JOIN symptoms ON meal.symptomsID = symptoms.symptomsID 
        WHERE meal.mealID = ? AND (
        symptoms.generalWellbeing >= ? OR 
        symptoms.cramps >= ? OR 
        symptoms.flatulence >= ? OR 
        symptoms.bowel >= ?)""",
        [
          mealID,
          filterNumberLow,
          filterNumberLow,
          filterNumberLow,
          filterNumberLow
        ]);
    var allMealsWithSymptoms = allMeals.toList();
    return allMealsWithSymptoms;
  }


  getMealIngredient(int index) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'mealingredient',
      where: 'mealID = ?',
      whereArgs: [index],
    );

    return List.generate(maps.length, (i) {
      return MealIngredientData(
        mealIngredientID: maps[i]['mealIngredientID'],
        mealID: maps[i]['mealID'],
        ingredientID: maps[i]['ingredientID'],
      );
    });
  }

  getIngredients() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('ingredient');

    return List.generate(maps.length, (i) {
      return IngredientData(
        ingredientID: maps[i]['ingredientID'],
        ingredient: maps[i]['ingredient'],
      );
    });
  }

  getIngredientID(int index) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('ingredient');

    return List.generate(maps.length, (i) {
      return IngredientData(
        ingredientID: maps[i]['ingredientID'],
        ingredient: maps[i]['ingredient'],
      );
    });
  }

  getHighestSymptomsID() async {
    final db = await database;
    List<Map<String, dynamic>> lastInsertedSymptoms = await db
        .rawQuery('SELECT * FROM symptoms ORDER BY symptomsID DESC LIMIT 1');
    var symptomsID = lastInsertedSymptoms.toList();
    return symptomsID;
  }

  addSymptomsToMeal(int symptomsID, int mealID) async {
    final db = await database;
    await db.rawUpdate(
        """UPDATE meal
        SET symptomsID = ?
        WHERE mealID = ?""",
        [symptomsID, mealID]);
  }

  getDeleteMealInformation(int mealID) async {
    final db = await database;
    List<Map<String, dynamic>> deleteMealInformation = await db.rawQuery(
        """SELECT meal.mealID, symptoms.symptomsID
        FROM meal
        JOIN symptoms ON meal.symptomsID = symptoms.symptomsID
        WHERE meal.mealID = ?""", [mealID]);
    var symptomsID = deleteMealInformation.toList();
    return symptomsID;
  }

  Future<void> insertMeal(MealData meal) async {
    final db = await database;
    await db.insert(
      'meal',
      meal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertMealz(MealData meal) async {
    final db = await database;
    await db.rawInsert("""INSERT INTO meal(""");
  }

  deleteMeal(int mealID, int symptomsID) async {
    final db = await database;
    await db.rawDelete("""DELETE FROM meal
        WHERE mealID = ?""", [mealID]);
    await db.rawDelete("""DELETE FROM mealingredient
        WHERE mealID = ?""", [mealID]);
    await db.rawDelete("""DELETE FROM symptoms
        WHERE symptomsID = ?""", [symptomsID]);
  }

  Future<void> createMealIngredient(MealIngredientData mealIngredient) async {
    final db = await database;

    await db.insert(
      'mealingredient',
      mealIngredient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> createMealIngredients(int mealID, int ingredientID) async {
    final db = await database;
    await db.rawInsert(
        """INSERT INTO mealingredient(mealID, ingredientID) VALUES(?,?)""",
        [mealID, ingredientID]);
  }

  Future<void> insertIngredient(IngredientData ingredient) async {
    final db = await database;
    await db.insert(
      'ingredient',
      ingredient.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<void> insertSymptoms(SymptomData symptoms) async {
    final db = await database;
    await db.insert(
      'symptoms',
      symptoms.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  getAllIngredients() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('ingredient');

    return List.generate(maps.length, (i) {
      return IngredientData(
        ingredient: maps[i]['ingredient'],
      );
    });
  }

  Future<void> deleteMealz(int id) async {
    final db = await database;
    await db.delete(
      'meal',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

}
