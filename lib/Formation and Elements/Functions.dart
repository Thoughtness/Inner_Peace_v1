import 'package:flutter/material.dart';

freeOrUsed(bool isAvailable){
  if(isAvailable){
    return "Benutzerkonto wurde erstellt";
  }else {
    return "Benutzername ist vergeben";
  }
}
barColorMeal(double index) {
  Color color = Colors.black;

  if (index <= 2) {
    color = Colors.green;
  } else if (index <= 4) {
    color = Colors.yellow;
  } else if (index <= 7) {
    color = Colors.orange;
  } else{
    color = Colors.red;
  }
  return color;
}

barColor(double index) {
  Color color = Colors.black;

  if (index <= 4) {
    color = Colors.green;
  } else if (index <= 7) {
    color = Colors.yellow;
  } else if (index <= 10) {
    color = Colors.orange;
  } else {
    color = Colors.red;
  }
  return color;
}

barLengthSymptoms(double ingredient) {
  double barLength = ingredient * 100;
  return barLength.toInt();
}

opposingBarLengthSymptomsMeal(double ingredient) {
  double barLength = 1000 - ingredient * 100;
  return barLength.toInt();
}

opposingBarLengthSymptoms(double ingredient) {
  double barLength = 1500 - ingredient * 100;
  return barLength.toInt();
}

getMealListLength(String ingredient, List<Map<String, dynamic>> mealsFromIngredients) {
  int counter = 0;
  for (int i = 0; i < mealsFromIngredients.length; i++) {
    if (ingredient == mealsFromIngredients[i]['ingredient']) {
      counter++;
    }
  }
  return counter;
}

getSymptomTimeTotalLength(List<Map<String, dynamic>> mealsFromIngredients, String index) {
  int counter = 0;
  for (int i = 0; i < mealsFromIngredients.length; i++) {
    if (index == mealsFromIngredients[i]['ingredient']) {
      counter++;
    }
  }
  return counter;
}

getSymptomTimeLength(String symptomTime, List<Map<String, dynamic>> mealsFromIngredients, String index) {
  int counter = 0;
  for (int i = 0; i < mealsFromIngredients.length; i++) {
    if (index == mealsFromIngredients[i]['ingredient'] && symptomTime == mealsFromIngredients[i]['symptomTime']) {
      counter++;
    }
  }
  return counter;
}

amountMultiplicator(double amount){
  return 0.5+amount/10;
}

//Gibt entsprechend des CustomCheckbox eine Liste von Zutaten zurück
getIngredients(bool primary, bool secondary1, bool secondary2, bool allIsChecked, List<Map<String, dynamic>> primaryList, List<Map<String, dynamic>> secondaryList1, List<Map<String, dynamic>> secondaryList2, List<Map<String, dynamic>> allIngredientsWithSymptoms,
    String sort) {
  if (primary) {
    allIngredientsWithSymptoms = primaryList;
    if (allIsChecked) {
      allIngredientsWithSymptoms =
          primaryList + secondaryList1 + secondaryList2;
    } else if (secondary1) {
      allIngredientsWithSymptoms = primaryList + secondaryList1;
    } else if (secondary2) {
      allIngredientsWithSymptoms = primaryList + secondaryList2;
    }
  } else if (!primary && secondary1 && secondary2) {
    allIngredientsWithSymptoms = secondaryList1 + secondaryList2;
  } else if (!primary && secondary1) {
    allIngredientsWithSymptoms = secondaryList1;
  } else if (!primary && secondary2) {
    allIngredientsWithSymptoms = secondaryList2;
  } else if (!primary && !secondary1 && !secondary2) {
    allIngredientsWithSymptoms = [];
  }
  allIngredientsWithSymptoms = sortList(sort, allIngredientsWithSymptoms);
  return allIngredientsWithSymptoms;
}

//Sortiert die Liste nach Verträglichkeit
sortList(String sort, List<Map<String, dynamic>> allIngredientsWithSymptoms ) {
  if (sort == "Unverträglich") {
    allIngredientsWithSymptoms.sort((a, b) => b["symptomTotal"]
        .compareTo(a["symptomTotal"]));
  } else if (sort == "Verträglich") {
    allIngredientsWithSymptoms.sort((a, b) => a["symptomTotal"]
        .compareTo(b["symptomTotal"]));
  }
  return allIngredientsWithSymptoms;
}

//Prüft welche Checkboxes angewählt sind und passt allIsChecked an
setCheckboxState(bool warningsIsChecked, bool digestibleIsChecked, bool symptomFreeIsChecked, bool allIsChecked) {
  if (warningsIsChecked == false ||
      digestibleIsChecked == false ||
      symptomFreeIsChecked == false) {
    allIsChecked = false;
  } else if (warningsIsChecked == true &&
      digestibleIsChecked == true &&
      symptomFreeIsChecked == true) {
    allIsChecked = true;
  }
  return allIsChecked;
}