class MealIngredientData {
  int? mealIngredientID;
  int mealID;
  int ingredientID;

  MealIngredientData({
    this.mealIngredientID,
    required this.mealID,
    required this.ingredientID,
  });

  Map<String, dynamic> toMap() {
    return {
      'mealIngredientID': mealIngredientID,
      'mealID': mealID,
      'ingredientID': ingredientID,
    };
  }
}