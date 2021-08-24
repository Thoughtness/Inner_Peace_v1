import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  get database async {
    if (_database != null) return _database!;

    _database = await _initDB('mealData60.db');
    return _database!;
  }

  _initDB(String filePath) async {
    final path = join(await getDatabasesPath(), filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  _createDB(Database db, int version) async {
    await db.execute("""
    CREATE TABLE user(
    userID INTEGER PRIMARY KEY
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

  insertMeal(String meal, int time) async {
    final db = await database;
    await db.rawInsert(
        """INSERT OR IGNORE INTO meal(meal, time)
        VALUES(?, ?)""",
        [meal, time]);
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
//here
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
        WHERE meal.mealID = ?""",
        [mealID]);
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
        AND symptoms.wellbeing BETWEEN ? and ?
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
        WHERE meal.mealID = ? AND (
        symptoms.wellbeing >= ? OR 
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
        WHERE symptomsID IS NULL""");
    return symptomlessMeals;
  }

  getMealsFromIngredients() async {
    final db = await database;
    List<Map<String, dynamic>> mealsFromIngredients = await db.rawQuery(
        """SELECT meal.meal, ingredient.ingredientID, ingredient.ingredient, symptoms.symptomTime
        FROM meal
        JOIN symptoms ON meal.symptomsID = symptoms.symptomsID
        JOIN mealingredient ON meal.mealID = mealingredient.mealID 
        JOIN ingredient ON mealingredient.ingredientID = ingredient.ingredientID""");
    return mealsFromIngredients;
  }

  getIngredients() async {
    final db = await database;
    final List<Map<String, dynamic>> getIngredientsWithSymptoms = await db
        .rawQuery(
        """SELECT ingredient.ingredientID, ingredient.ingredient FROM ingredient""");
    return getIngredientsWithSymptoms;
  }

  getAllIngredientsWithSymptoms(int ingredientID) async {
    final db = await database;
    final List<Map<String, dynamic>> allIngredientsWithMeals = await db
        .rawQuery(
        """SELECT ingredient.ingredientID, ingredient.ingredient, avg(mealingredient.amount), meal.meal, sum(symptoms.symptomTotal), avg(symptoms.wellbeing), avg(symptoms.flatulence), avg(symptoms.cramps), avg(symptoms.bowel)
        FROM ingredient
        JOIN mealingredient ON ingredient.ingredientID = mealingredient.ingredientID
        JOIN meal ON mealingredient.mealID = meal.mealID
        JOIN symptoms ON meal.symptomsID = symptoms.symptomsID
        WHERE ingredient.ingredientID = ?""",
        [ingredientID]);
    return allIngredientsWithMeals;
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
        WHERE ingredient.ingredientID = ?""",
        [ingredientID]);
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


// getSymptomsID() async {
//   final db = await database;
//   List<Map<String, dynamic>> lastInsertedMeal = await db.rawQuery(
//       """SELECT symptoms.symptomsID
//       FROM symptoms""");
//   //var mealID = lastInsertedMeal.toList();
//   return lastInsertedMeal;
// }
  //
  // getIngredientsWithSymptoms() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> getIngredientsWithSymptoms = await db.rawQuery(
  //       """SELECT ingredient.ingredientID, ingredient.ingredient
  //       FROM ingredient
  //       JOIN mealingredient ON ingredient.ingredientID = mealingredient.ingredientID
  //       JOIN meal ON mealingredient.mealID = meal.mealID
  //       JOIN symptoms ON meal.symptomsID = symptoms.symptomsID
  //       WHERE symptoms.symptomTotal NOT NULL""");
  //   //var getIngredientsWithSymptoms = getIngredientsWithSymptoms.toList();
  //   print(getIngredientsWithSymptoms);
  //   return getIngredientsWithSymptoms;
  // }


  //
  // getMealIngredient(int index) async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query(
  //     'mealingredient',
  //     where: 'mealID = ?',
  //     whereArgs: [index],
  //   );
  //
  //   return List.generate(maps.length, (i) {
  //     return MealIngredientData(
  //       mealIngredientID: maps[i]['mealIngredientID'],
  //       mealID: maps[i]['mealID'],
  //       ingredientID: maps[i]['ingredientID'],
  //     );
  //   });
  // }

  // getIngredients2() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query('ingredient');
  //
  //   print(maps);
  //   return List.generate(maps.length, (i) {
  //     return IngredientData(
  //       ingredientID: maps[i]['ingredientID'],
  //       ingredient: maps[i]['ingredient'],
  //     );
  //   });
  // }

  // getHighestIngredientID() async {
  //   // final db = await database;
  //   // final List<Map<String, dynamic>> maps = await db.query('ingredient');
  //   //
  //   // return List.generate(maps.length, (i) {
  //   //   return IngredientData(
  //   //     ingredientID: maps[i]['ingredientID'],
  //   //     ingredient: maps[i]['ingredient'],
  //   //   );
  //   // });
  //
  //   final db = await database;
  //   List<Map<String, dynamic>> lastInsertedIngredient =
  //   await db.rawQuery(
  //       """SELECT * FROM ingredient
  //       ORDER BY ingredientID DESC
  //       LIMIT 1""");
  //   var ingredientID = lastInsertedIngredient.toList();
  //   return ingredientID;
  // }



  // Future<void> insertMeals(MealData meal) async {
  //   final db = await database;
  //   await db.insert(
  //     'meal',
  //     meal.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }

  //
  // Future<void> createMealIngredients(MealIngredientData mealIngredient) async {
  //   final db = await database;
  //
  //   await db.insert(
  //     'mealingredient',
  //     mealIngredient.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.ignore,
  //   );
  // }



  // Future<void> insertIngredient(IngredientData ingredient) async {
  //   final db = await database;
  //   await db.insert(
  //     'ingredient',
  //     ingredient.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.ignore,
  //   );
  // }


  //
  // Future<void> insertSymptoms(SymptomData symptoms) async {
  //   final db = await database;
  //   // await db.rawInsert(
  //   //   """INSERT OR REPLACE INTO symptoms(wellbeing, cramps, flatulence, bowel, ) VALUES(?,?)""",)
  //   await db.insert(
  //     'symptoms',
  //     symptoms.toMap(),
  //     conflictAlgorithm: ConflictAlgorithm.replace,
  //   );
  // }
