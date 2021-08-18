import 'package:flutter/material.dart';

barColor(int index) {
  Color color = Colors.black;

  if (index <= 3) {
    color = Colors.green;
  } else if (index <= 5) {
    color = Colors.yellow;
  } else if (index <= 8) {
    color = Colors.orange;
  } else if (index <= 10) {
    color = Colors.red;
  } else if (index > 10) {
    color = Colors.grey;
  }
  return color;
}

barLengthSymptoms(double ingredient) {
  double barLength = ingredient * 100;
  return barLength.toInt();
}

opposingBarLengthSymptoms(double ingredient) {
  double barLength = 1000 - ingredient * 100;
  //double opposingBarLength = 1000 - barLength;
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
