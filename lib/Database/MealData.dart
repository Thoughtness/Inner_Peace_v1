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


@override
String toString() {
  return 'Mahlzeit{id: $mealID, meal: $meal}';
}
}
