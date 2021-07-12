class SymptomData {
  int symptomID;
  double? symptomTotal;
  double? generalWellbeing;
  double? cramps;
  double? flatulence;
  double? bowel;

  SymptomData({
    required this.symptomID,
    this.symptomTotal,
    this.generalWellbeing,
    this.cramps,
    this.flatulence,
    this.bowel,
  });

  Map<String, dynamic> toMap() {
    return {
      'ingredientID': symptomID,
      'symptomTotal': symptomTotal,
      'generalWellbeing': generalWellbeing,
      'cramps': cramps,
      'flatulence': flatulence,
      'bowel': bowel,
    };
  }
}