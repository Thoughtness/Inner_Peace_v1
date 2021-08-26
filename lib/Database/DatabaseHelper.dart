import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/MyUser.dart';

class DatabaseHelper {
  MyUser _myUser = MyUser();
  get userId => _myUser.myUserId;

  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  get database async {
    if (_database != null) return _database!;

    _database = await _initDB('mealData65.db');
    return _database!;
  }

  _initDB(String filePath) async {
    final path = join(await getDatabasesPath(), filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  _createDB(Database db, int version) async {
    await db.execute("""
    CREATE TABLE user(
    userID INTEGER PRIMARY KEY,
    username TEXT
    );""");
    await db.execute("""
    CREATE TABLE meal(
    mealID INTEGER PRIMARY KEY,
    symptomsID INTEGER,
    userID INTEGER,
    meal TEXT,
    time INTEGER,
    FOREIGN KEY(symptomsID) REFERENCES symptoms(symptomsID),
    FOREIGN KEY(userID) REFERENCES user(userID)
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
    wellbeing REAL,
    cramps REAL,
    flatulence REAL,
    bowel REAL,
    symptomTime INTEGER
    );""");
    await db.execute("""
    CREATE TABLE mealingredient(
    mealingredientID INTEGER PRIMARY KEY,
    amount INTEGER,
    mealID INTEGER,
    ingredientID INTEGER,
    FOREIGN KEY(mealID) REFERENCES meal(mealID),
    FOREIGN KEY(ingredientID) REFERENCES ingredient(ingredientID)
    );""");
  }
  insertUser(String user) async {
    final db = await database;
    await db.rawInsert(
        """INSERT OR IGNORE INTO user(username) VALUES(?)""",
        [user]);
  }

  insertMeal(String meal, int time) async {
    final db = await database;
    await db.rawInsert(
        """INSERT OR IGNORE INTO meal(userID, meal, time)
        VALUES(?, ?, ?)""",
        [userId, meal, time]);
  }

  insertIngredient(String ingredient) async {
    final db = await database;
    await db.rawInsert(
        """INSERT OR IGNORE INTO ingredient(ingredient) VALUES(?)""",
        [ingredient]);
  }

  insertSymptoms(double wellbeing, double cramps,
      double flatulence, double bowel, double symptomTotal,
      String symptomTime) async {
    final db = await database;
    await db.rawInsert(
        """INSERT OR REPLACE INTO symptoms(wellbeing, cramps, flatulence, bowel, symptomTotal, symptomTime) VALUES(?,?,?,?,?,?)""",
        [wellbeing, cramps, flatulence, bowel, symptomTotal, symptomTime]);
  }

  addSymptomsToMeal(int symptomsID, int mealID) async {
    final db = await database;
    await db.rawUpdate(
        """UPDATE meal
        SET symptomsID = ?
        WHERE mealID = ?""",
        [symptomsID, mealID]);
  }

  createMealIngredient(int mealID, int ingredientID,
      double amount) async {
    final db = await database;
    await db.rawInsert(
        """INSERT OR IGNORE INTO mealingredient(mealID, ingredientID, amount) VALUES(?,?,?)""",
        [mealID, ingredientID, amount]);
  }

  getLoginDetails(String username) async {
    final db = await database;
    try {
      List<Map<String, dynamic>> loginDetails = await db.rawQuery(
          """SELECT * FROM user
        WHERE username = ?""",
          [username]);
      return loginDetails;
    } catch (e) {
      return null;
    }
  }

  getHighestMealID() async {
    final db = await database;
    List<Map<String, dynamic>> lastInsertedMeal = await db.rawQuery(
        """SELECT * FROM meal 
        ORDER BY mealID DESC 
        LIMIT 1""");
    return lastInsertedMeal;
  }

  getAllRecordedMeals(int mealID) async {
    final db = await database;
    List<Map<String, dynamic>> allMeals = await db.rawQuery(
        """SELECT meal.mealID, meal.meal, meal.time, symptoms.wellbeing, symptoms.cramps, symptoms.flatulence, symptoms.bowel, symptoms.symptomTotal
        FROM meal 
        JOIN mealingredient ON meal.mealID = mealingredient.mealID 
        JOIN ingredient ON mealingredient.ingredientID = ingredient.ingredientID 
        JOIN symptoms ON meal.symptomsID = symptoms.symptomsID 
        WHERE meal.mealID = ? AND meal.userID = ?""",
        [mealID, userId]);
    return allMeals;
  }

  getCertainRecordedMeals(int mealID, double filterNumberLow,
      double filterNumberHigh) async {
    final db = await database;
    List<Map<String, dynamic>> allMeals = await db.rawQuery(
        """SELECT meal.mealID, meal.meal, meal.time, symptoms.wellbeing, symptoms.cramps, symptoms.flatulence, symptoms.bowel, symptoms.symptomTotal
        FROM meal 
        JOIN mealingredient ON meal.mealID = mealingredient.mealID 
        JOIN ingredient ON mealingredient.ingredientID = ingredient.ingredientID 
        JOIN symptoms ON meal.symptomsID = symptoms.symptomsID 
        WHERE meal.mealID = ?
        AND meal.userID = ?
        AND symptoms.wellbeing BETWEEN ? and ?
        AND symptoms.cramps BETWEEN ? and ?
        AND symptoms.flatulence BETWEEN ? and ?
        AND symptoms.bowel BETWEEN ? and ?""",
        [
          mealID,
          userId,
          filterNumberLow,
          filterNumberHigh,
          filterNumberLow,
          filterNumberHigh,
          filterNumberLow,
          filterNumberHigh,
          filterNumberLow,
          filterNumberHigh
        ]);
    return allMeals;
  }

  getIntolerantRecordedMeals(int mealID, double filterNumberLow) async {
    final db = await database;
    List<Map<String, dynamic>> allMeals = await db.rawQuery(
        """SELECT meal.mealID, meal.meal, meal.time, symptoms.wellbeing, symptoms.cramps, symptoms.flatulence, symptoms.bowel, symptoms.symptomTotal
        FROM meal 
        JOIN mealingredient ON meal.mealID = mealingredient.mealID 
        JOIN ingredient ON mealingredient.ingredientID = ingredient.ingredientID 
        JOIN symptoms ON meal.symptomsID = symptoms.symptomsID 
        WHERE meal.mealID = ? 
        AND meal.userID = ? AND (
        symptoms.wellbeing >= ? OR 
        symptoms.cramps >= ? OR 
        symptoms.flatulence >= ? OR 
        symptoms.bowel >= ?)""",
        [
          mealID,
          userId,
          filterNumberLow,
          filterNumberLow,
          filterNumberLow,
          filterNumberLow
        ]);
    return allMeals;
  }

  getDeleteMealInformation(int mealID) async {
    final db = await database;
    List<Map<String, dynamic>> deleteMealInformation = await db.rawQuery(
        """SELECT meal.mealID, symptoms.symptomsID
            FROM meal
            JOIN symptoms ON meal.symptomsID = symptoms.symptomsID
            WHERE meal.mealID = ?""",
        [mealID]);
    return deleteMealInformation;
  }

  getSymptomlessMeals() async {
    final db = await database;
    List<Map<String, dynamic>> symptomlessMeals = await db.rawQuery(
        """SELECT * FROM meal
        WHERE symptomsID IS NULL
        AND meal.userID = ?""",
        [userId]);
    return symptomlessMeals;
  }

  getMealsFromIngredients() async {
    final db = await database;
    List<Map<String, dynamic>> mealsFromIngredients = await db.rawQuery(
        """SELECT meal.meal, ingredient.ingredientID, ingredient.ingredient, symptoms.symptomTime
        FROM meal
        JOIN symptoms ON meal.symptomsID = symptoms.symptomsID
        JOIN mealingredient ON meal.mealID = mealingredient.mealID 
        JOIN ingredient ON mealingredient.ingredientID = ingredient.ingredientID
        WHERE meal.userID = ?""",
        [userId]);
    return mealsFromIngredients;
  }

  getIngredients() async {
    final db = await database;
    final List<Map<String, dynamic>> getIngredientsWithSymptoms = await db
        .rawQuery(
        """SELECT ingredient.ingredientID, ingredient.ingredient FROM ingredient""");
    return getIngredientsWithSymptoms;
  }

  getAllIngredientsWithSymptoms2(int ingredientID) async {
    final db = await database;
    final List<Map<String, dynamic>> allIngredientsWithMeals = await db
        .rawQuery(
        """SELECT ingredient.ingredientID, ingredient.ingredient, mealingredient.amount, meal.meal, symptoms.symptomTotal, symptoms.wellbeing, symptoms.flatulence, symptoms.cramps, symptoms.bowel
        FROM ingredient
        JOIN mealingredient ON ingredient.ingredientID = mealingredient.ingredientID
        JOIN meal ON mealingredient.mealID = meal.mealID
        JOIN symptoms ON meal.symptomsID = symptoms.symptomsID
        WHERE ingredient.ingredientID = ?
        AND meal.userID = ?""",
        [ingredientID, userId]);
    return allIngredientsWithMeals;
  }

  getHighestSymptomsID() async {
    final db = await database;
    List<Map<String, dynamic>> lastInsertedSymptoms = await db.rawQuery(
        """SELECT *
        FROM symptoms
        ORDER BY symptomsID DESC
        LIMIT 1""");
    return lastInsertedSymptoms;
  }

  deleteMeal(int mealID, int symptomsID) async {
    final db = await database;
    await db.rawDelete(
        """DELETE FROM meal
        WHERE mealID = ?""",
        [mealID]);
    await db.rawDelete(
        """DELETE FROM mealingredient
        WHERE mealID = ?""",
        [mealID]);
    await db.rawDelete(
        """DELETE FROM symptoms
        WHERE symptomsID = ?""",
        [symptomsID]);
  }
}