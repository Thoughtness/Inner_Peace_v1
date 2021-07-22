class SymptomData {
  int? symptomsID;
  double? symptomTotal;
  double? generalWellbeing;
  double? cramps;
  double? flatulence;
  double? bowel;

  SymptomData({
    this.symptomsID,
    this.symptomTotal,
    this.generalWellbeing,
    this.cramps,
    this.flatulence,
    this.bowel,
  });

  Map<String, dynamic> toMap() {
    return {
      'symptomsID': symptomsID,
      'symptomTotal': symptomTotal,
      'generalWellbeing': generalWellbeing,
      'cramps': cramps,
      'flatulence': flatulence,
      'bowel': bowel,
    };
  }
}