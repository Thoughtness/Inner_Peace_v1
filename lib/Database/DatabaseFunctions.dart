import 'package:inner_peace_v1/Database/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/Functions.dart';

//Benutzername überprüfen, gibt wenn vorhanden true zurück
checkLogin(String username) async {
  var getLogin = await DatabaseHelper.instance.getLoginDetails(username);
  try {
    if (getLogin[0]['username'] == username){
      return getLogin;
    }
  } catch (e){
    return null;
  }
}

//Überprüft, ob ein Benutzername vorhanden ist. Wenn nicht wird er abgespeichert
ifAvailableSave(String username) async {
  var checkAvailability = await DatabaseHelper.instance.getLoginDetails(username);
  try {
    if (checkAvailability[0]['username'] == username){
      return false;
    }
  } catch (e){
    await DatabaseHelper.instance.insertUser(username);
    return true;
  }
}

//Geht die ganze Gericht Liste (mit entsprechender Benutzer ID) und fügt das Gericht der Zutat hinzu
getMealsForIngredient(int mealCounter, String ingredient, List<Map<String, dynamic>> mealsFromIngredients) {
  var mealsForIngredient = [];
  for (int i = 0; i < mealsFromIngredients.length; i++) {
    if (ingredient == mealsFromIngredients[i]['ingredient']) {
      mealsForIngredient.add(mealsFromIngredients[i]['meal']);
    }
  }
  return mealsForIngredient[mealCounter].toString();
}

//Holt die Informationen um ein Gericht zu löschen und löscht dann das Mahlzeit, die Symptome und MahlzeitZutat.
//Die Zutaten werden nicht gelöscht für die Zukunft, für Vorschläge zur Erfassung von Mahlzeiten
Future deleteMeal(int index) async {
  var deleteMealInformation = await DatabaseHelper.instance.getDeleteMealInformation(index);
  print(deleteMealInformation);

  await DatabaseHelper.instance.deleteMeal(index, deleteMealInformation[0]['symptomsID']);
}

//Filter und Sortierung für erfasste Mahlzeiten
getMealList(String? value, String? sort) async {
  List<Map<String, dynamic>> mealList = [];
  double filterNumberLow = 0;
  double filterNumberHigh = 0;

  var mealCount = await DatabaseHelper.instance.getHighestMealID();
  int numbOfMeals = mealCount[0]['mealID'];
  print(numbOfMeals);
  if (value == 'Alle') {
    for (int i = 1; i <= numbOfMeals; i++) {
      try {
        var meal = await DatabaseHelper.instance.getAllRecordedMeals(i);
        mealList.add(meal[0]);
      } catch (e) {

      }
    }
  } else if (value == "Symptomfrei") {
    filterNumberLow = -21;
    filterNumberHigh = -19;
    for (int i = 1; i <= numbOfMeals; i++) {
      try {
        var meal = await DatabaseHelper.instance
            .getCertainRecordedMeals(i, filterNumberLow, filterNumberHigh);
        mealList.add(meal[0]);
      } catch (e) {

      }
    }
  } else if (value == "Verträglich") {
    filterNumberLow = 0;
    filterNumberHigh = 6;
    for (int i = 1; i <= numbOfMeals; i++) {
      try {
        var meal = await DatabaseHelper.instance
            .getCertainRecordedMeals(i, filterNumberLow, filterNumberHigh);
        mealList.add(meal[0]);
      } catch (e) {

      }
    }
  } else if (value == "Unverträglich") {
    filterNumberLow = 7;
    for (int i = 1; i <= numbOfMeals; i++) {
      try {
        var meal = await DatabaseHelper.instance
            .getIntolerantRecordedMeals(i, filterNumberLow);
        mealList.add(meal[0]);
      } catch (e) {

      }
    }
  }

  if (sort == "Mahlzeitdatum") {
    mealList.sort((a, b) => a["time"].compareTo(b["time"]));
  } else if (sort == "Name A-Z") {
    mealList.sort((a, b) => a["meal"].compareTo(b["meal"]));
  } else if (sort == "Name Z-A") {
    mealList.sort((a, b) => b["meal"].compareTo(a["meal"]));
  } else if (sort == "Verträglichkeit") {
    mealList.sort((a, b) => a["symptomTotal"].compareTo(b["symptomTotal"]));
  } else if (sort == "Unverträglichkeit") {
    mealList.sort((a, b) => b["symptomTotal"].compareTo(a["symptomTotal"]));
  }
  return mealList;
}

//Symptome erfassen und diese nach grün, gelb und rot sortieren
addSymptoms(double wellbeing, double cramps, double flatulence, double bowel, int mealID, String symptomTime) async {
  //Multiplikator für Symptome = je schlimmer die Symptome desto höher der Multiplikator (eine 10 ist wesentlich schlimmer wie 4* eine 3)
  List<double> symptomList = [wellbeing, cramps, flatulence, bowel];

  for (int i = 0; i <= 3; i++) {
    if (symptomList[i] == 6) {
      symptomList[i] = symptomList[i] * 1.25;
    } else if (symptomList[i] == 7) {
      symptomList[i] = symptomList[i] * 1.5;
    } else if (symptomList[i] == 8) {
      symptomList[i] = symptomList[i] * 2;
    } else if (symptomList[i] == 9) {
      symptomList[i] = symptomList[i] * 2.75;
    } else if (symptomList[i] == 10) {
      symptomList[i] = symptomList[i] * 4;
    }
  }

  var symptomTotal = symptomList[0] + symptomList[1] + symptomList[2] + symptomList[3];
  await DatabaseHelper.instance.insertSymptoms(wellbeing, cramps, flatulence, bowel, symptomTotal, symptomTime);

  //letze symptomsID herausholen
  var lastInsertedSymptoms =
  await DatabaseHelper.instance.getHighestSymptomsID();
  int symptomsID = lastInsertedSymptoms[0]['symptomsID'];

  await DatabaseHelper.instance.addSymptomsToMeal(symptomsID, mealID);
}

//Mahlzeit mit Zutaten und Menge erfassen
addMealWithIngredients(String? sqlFormatedDate, String? sqlFormatedTime, List<String> ingredientList, TextEditingController mealName, List<double> amount) async {
  DateTime sqlDate =
  DateTime.parse(sqlFormatedDate! + "T" + sqlFormatedTime!);
  await DatabaseHelper.instance
      .insertMeal(mealName.text, sqlDate.millisecondsSinceEpoch);

  var lastInsertedMeal = await DatabaseHelper.instance.getHighestMealID();
  int mealID = lastInsertedMeal[0]['mealID'];

  //Zutaten in Tabelle einfügen
  for (int i = 0; i < ingredientList.length; i++) {
    await DatabaseHelper.instance.insertIngredient(ingredientList[i]);
  }

  //Alle Zutaten mit zugehörigen IDs holen und mealIngredients erstellen
  var ingredientListID = await DatabaseHelper.instance.getIngredients();
  var amountCounter = 0;
  for (int i = 0; i < ingredientListID.length; i++) {
    if (ingredientList.contains(ingredientListID[i]['ingredient'])) {
      await DatabaseHelper.instance.createMealIngredient(mealID, ingredientListID[i]['ingredientID'], amount[amountCounter]);
      amountCounter ++;
    }
  }
  return mealID;
}

//Multiplikator für die Menge der Zutat berechnen bevor diese mit den Zutaten gelistet werden
filteredAverageSymptomsListWithAmount(String filterColor) async{
  var allIngredients = await DatabaseHelper.instance.getIngredients();
  List<Map<String, dynamic>> ingredientSymptomAmount = [];

  double symptomtotalAmount = 0;
  double wellbeingAmount = 0;
  double flatulenceAmount = 0;
  double crampsAmount = 0;
  double bowelAmount = 0;

//Multiplikator für die Menge der Zutaten anwenden, diese addieren und denn Schnitt berechnen
  for(int i = 0; i < allIngredients.length; i++){
    if(!ingredientSymptomAmount.contains(allIngredients[i]['ingredientID'])){
      var singleIngredient = await DatabaseHelper.instance.getAllIngredientsWithSymptoms(allIngredients[i]['ingredientID']);
      for(int e = 0; e < singleIngredient.length; e++){
        symptomtotalAmount = symptomtotalAmount + singleIngredient[e]['symptomTotal']*amountMultiplicator(singleIngredient[e]['amount'].toDouble());
        wellbeingAmount = wellbeingAmount + singleIngredient[e]['wellbeing']*amountMultiplicator(singleIngredient[e]['amount'].toDouble());
        flatulenceAmount = flatulenceAmount + singleIngredient[e]['flatulence']*amountMultiplicator(singleIngredient[e]['amount'].toDouble());
        crampsAmount = crampsAmount + singleIngredient[e]['cramps']*amountMultiplicator(singleIngredient[e]['amount'].toDouble());
        bowelAmount = bowelAmount + singleIngredient[e]['bowel']*amountMultiplicator(singleIngredient[e]['amount'].toDouble());
      }

      wellbeingAmount = wellbeingAmount/singleIngredient.length;
      flatulenceAmount = flatulenceAmount/singleIngredient.length;
      crampsAmount = crampsAmount/singleIngredient.length;
      bowelAmount = bowelAmount/singleIngredient.length;

      //print(singleIngredient);
      //Neue Liste generieren
      List<Map<String, dynamic>> updatedIngredient = [{'ingredientID': singleIngredient[0]['ingredientID'], 'ingredient': singleIngredient[0]['ingredient'], 'amount': singleIngredient[0]['amount'], 'meal': singleIngredient[0]['meal'], 'symptomTotal': symptomtotalAmount, 'wellbeing': wellbeingAmount, 'flatulence': flatulenceAmount, 'cramps': crampsAmount, 'bowel': bowelAmount}];
      print(updatedIngredient);
      try {
        switch (filterColor) {
          case "green":
            if (singleIngredient[0]['symptomTotal'] <= 0) {
              ingredientSymptomAmount.add(updatedIngredient[0]);
            }
            break;
          case "yellow":
            if (singleIngredient[0]['symptomTotal'] <= 160 &&
                singleIngredient[0]['symptomTotal'] > 0) {
              ingredientSymptomAmount.add(updatedIngredient[0]);
            }
            break;
          case "red":
            if (singleIngredient[0]['symptomTotal'] > 160) {
              ingredientSymptomAmount.add(updatedIngredient[0]);
            }
            break;
        }
      } catch (e) {

      }

      symptomtotalAmount = 0;
      wellbeingAmount = 0;
      flatulenceAmount = 0;
      crampsAmount = 0;
      bowelAmount = 0;
    }
  }
  return ingredientSymptomAmount;
}