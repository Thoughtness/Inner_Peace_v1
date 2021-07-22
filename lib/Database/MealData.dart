class MealData {
  int? mealID;
  late String meal;
  // int? symptomID;
  // int? mealIngredientID;
  //static final columns = ["id", "meal"];
  MealData({
    required this.meal,
    // this.symptomID,
    // this.mealIngredientID,
  });

  // factory MealData.fromMap(Map<String, dynamic> data) {
  //   return MealData(
  //     data['id'],
  //     data['meal'],
  //   );
  // }

  MealData.fromMap(Map<String, dynamic> map) {
    this.mealID = map['id'];
    this.meal = map['meal'];
  }

  Map<String, dynamic> toMap() {
    return {
      'mealID': mealID,
      'meal': meal,
      //'symptomID': id,
      //'ingredientsID': id,
    };
  }

// mealData.mapToObject(Map<String, dynamic> map){
//   this.meal = map['meal'];
//   this.ingredients = map['ingredients'];
//   this.symptomTotal = map['symptomTotal'];
//   this.generalWellbeing = map['generalWellbeing'];
//   this.cramps = map['cramps'];
//   this.flatulence = map['flatulence'];
//   this.bowel = map['bowel'];
// }

// @override
// String toString() {
//   return 'Mahlzeit{id: $id, meal: $meal, ingredients: $ingredients. symptomTotal: $symptomTotal, generalWellbeing: $generalWellbeing, cramps: $cramps, flatulence: $flatulence, bowel: $bowel}';
// }
}
