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
