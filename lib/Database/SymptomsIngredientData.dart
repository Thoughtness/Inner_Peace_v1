class SymptomsIngredientData {
  int? SymptomsIngredientID;
  int symptomsID;
  int ingredientID;

  SymptomsIngredientData({
    this.SymptomsIngredientID,
    required this.symptomsID,
    required this.ingredientID,
  });

  Map<String, dynamic> toMap() {
    return {
      'SymptomsIngredientID': SymptomsIngredientID,
      'symptomsID': symptomsID,
      'ingredientID': ingredientID,
    };
  }
}