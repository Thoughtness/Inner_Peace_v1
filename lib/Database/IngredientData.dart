class IngredientData {
  //int? id;
  int? ingredientID;
  String ingredient;
  double? symptomTotal;
  double? generalWellbeingAverage;
  double? crampsAverage;
  double? flatulenceAverage;
  double? bowelAverage;

  IngredientData({
    //this.id,
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
      //'id': id,
      'ingredientID': ingredientID,
      'ingredient': ingredient,
      'generalWellbeingAverage': generalWellbeingAverage,
      'crampsAverage': crampsAverage,
      'flatulenceAverage': flatulenceAverage,
      'bowelAverage': bowelAverage,
    };
  }
}