import 'package:flutter/material.dart';

freeOrUsed(bool isAvailable){
  if(isAvailable){
    return "Benutzerkonto wurde erstellt";
  }else {
    return "Benutzername ist vergeben";
  }
}

barColor(int index) {
  Color color = Colors.black;

  if (index <= 4) {
    color = Colors.green;
  } else if (index <= 7) {
    color = Colors.yellow;
  } else if (index <= 10) {
    color = Colors.orange;
  } else if (index <= 15) {
    color = Colors.red;
  } else if (index > 15) {
    color = Colors.grey;
  }
  return color;
}

barLengthSymptoms(double ingredient) {
  double barLength = ingredient * 100;
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

  // if(amount == 0){
  //   return 0.5;
  // }else if(amount == 1){
  //   return 0.6;
  // }else if(amount == 2){
  //   return 0.7;
  // }else if(amount == 3){
  //   return 0.8;
  // }else if(amount == 4){
  //   return 0.9;
  // }else if(amount == 5){
  //   return 1;
  // }else if(amount == 6){
  //   return 1.1;
  // }else if(amount == 7){
  //   return 1.2;
  // }else if(amount == 8){
  //   return 1.3;
  // }else if(amount == 9){
  //   return 1.4;
  // }else if(amount == 10){
  //   return 1.5;
  // }
}
