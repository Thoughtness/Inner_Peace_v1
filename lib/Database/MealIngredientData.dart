class MealIngredientData {
  int mealID;
  int ingredientID;

  MealIngredientData({
    required this.mealID,
    required this.ingredientID,
  });

  Map<String, dynamic> toMap() {
    return {
      'mealID': mealID,
      'ingredientID': ingredientID,
    };
  }
}