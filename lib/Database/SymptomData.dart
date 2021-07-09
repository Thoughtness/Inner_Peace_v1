class SymptomData {
  int? id;
  int symptomID;
  double? symptomTotal;
  double? generalWellbeing;
  double? cramps;
  double? flatulence;
  double? bowel;

  SymptomData({
    this.id,
    required this.symptomID,
    this.symptomTotal,
    this.generalWellbeing,
    this.cramps,
    this.flatulence,
    this.bowel,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'ingredientID': symptomID,
      'generalWellbeing': generalWellbeing,
      'cramps': cramps,
      'flatulence': flatulence,
      'bowel': bowel,
    };
  }
}