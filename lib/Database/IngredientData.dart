class IngredientData {
  int? ingredientID;
  String ingredient;
  double? symptomTotal;
  double? generalWellbeingAverage;
  double? crampsAverage;
  double? flatulenceAverage;
  double? bowelAverage;

  IngredientData({
    this.ingredientID,
    required this.ingredient,
    this.symptomTotal,
    this.generalWellbeingAverage,
    this.crampsAverage,
    this.flatulenceAverage,
    this.bowelAverage,
  });

  Map<String, dynamic> toMap() {
    return {
      'ingredientID': ingredientID,
      'ingredient': ingredient,
      'generalWellbeingAverage': generalWellbeingAverage,
      'crampsAverage': crampsAverage,
      'flatulenceAverage': flatulenceAverage,
      'bowelAverage': bowelAverage,
    };
  }
}