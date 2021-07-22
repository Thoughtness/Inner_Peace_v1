class IngredientData {
  int? ingredientID;
  String ingredient;

  IngredientData({
    this.ingredientID,
    required this.ingredient,
  });

  Map<String, dynamic> toMap() {
    return {
      'ingredientID': ingredientID,
      'ingredient': ingredient,
    };
  }
}