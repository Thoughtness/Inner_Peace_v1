// ignore: camel_case_types
class mealData{
  int? id;
  String meal;
  String ingredients;
  //List<String> ingredients;
  double? symptomTotal;
  double? generalWellbeing;
  double? cramps;
  double? flatulence;
  double? bowel;

  mealData({
    this.id,
    required this.meal,
    required this.ingredients,
    this.symptomTotal,
    this.generalWellbeing,
    this.cramps,
    this.flatulence,
    this.bowel,
  });

  // String get _meal => meal;

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'meal': meal,
      'ingredients': ingredients,
      'generalWellbeing': generalWellbeing,
      'cramps': cramps,
      'flatulence': flatulence,
      'bowel': bowel,
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