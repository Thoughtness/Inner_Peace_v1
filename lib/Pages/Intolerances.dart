import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/GuiElements.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/Formation and Elements/Formation.dart';
import 'package:inner_peace_v1/Database/DatabaseFunctions.dart';

class Intolerances extends StatefulWidget {
  Intolerances({
    required this.allIngredientsWithSymptoms,
    required this.mealsFromIngredients,
  });

  final List<Map<String, dynamic>> allIngredientsWithSymptoms;
  final List<Map<String, dynamic>> mealsFromIngredients;

  @override
  _Intolerances createState() => _Intolerances(
      allIngredientsWithSymptoms: allIngredientsWithSymptoms,
      mealsFromIngredients: mealsFromIngredients);
}

class _Intolerances extends State<Intolerances> {
  _Intolerances({
    required this.allIngredientsWithSymptoms,
    required this.mealsFromIngredients,
  });

  List<Map<String, dynamic>> allIngredientsWithSymptoms;
  List<Map<String, dynamic>> mealsFromIngredients;

  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 10.0;

  int mealCounter = 0;
  bool allIsChecked = false;
  bool warningsIsChecked = false;
  bool digestibleIsChecked = false;
  bool symptomFreeIsChecked = false;
  bool allTimeIsChecked = false;
  bool whileEating = false;
  bool firstHour = false;
  bool twoAndFive = false;
  bool afterFive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      endDrawer: Menu(),
      appBar: AppBar(
        title: Text(
          'Unverträglichkeiten',
          style: myAppBarTextStyle(),
        ),
        backgroundColor: Colors.cyanAccent,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image(
              image: AssetImage('assets/Inner_Peace.png'),
              fit: BoxFit.fill,
            ),
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(left, top, right, 0),
                  child: Container(
                    decoration: thickCyan(),
                    //ClipRRect damit wenn ExpansionTile aufgeklappt ist, dass die Ecken noch abgerundet sind. Nur mit Container sind diese aussen rund, jedoch innen eckig
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: ExpansionTile(
                        title: Text(
                          "Suchfilter",
                          style: mySliderTextStyle(),
                        ),
                        children: [
                          ExpansionTile(
                            title: Text(
                              "Verträglichkeit",
                              style: mySliderTextStyle(),
                            ),
                            children: [
                              customCheckbox("Alle anzeigen", allIsChecked),
                              customCheckbox("Warnungen anzeigen", warningsIsChecked),
                              customCheckbox(
                                  "Verträgliche anzeigen", digestibleIsChecked),
                              customCheckbox("Symptomfreie anzeigen",
                                  symptomFreeIsChecked),
                            ],
                          ),
                          ExpansionTile(
                            title: Text(
                              "Auftreten der Symptome",
                              style: mySliderTextStyle(),
                            ),
                            children: [
                              customCheckbox("Alle Zeiten", allTimeIsChecked),
                              customCheckbox("Während der Mahlzeit", whileEating),
                              customCheckbox("In der ersten Stunde", firstHour),
                              customCheckbox("Nach 2-5 Stunden", twoAndFive),
                              customCheckbox("Nach 5 Stunden", afterFive),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    itemCount: allIngredientsWithSymptoms.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Container(
                          decoration: thickTeal(),
                          child: Column(
                            children: [
                              Container(
                                decoration: thinCyan(),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          this.left, 0, 0, this.bottom),
                                      child: Text(
                                        allIngredientsWithSymptoms[index]
                                            ['ingredient'],
                                        style: myTitleCyanAccentTextStyle(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(this.left,
                                    this.top, this.right, this.bottom),
                                child: Column(
                                  children: [
                                    SymptomsRow(
                                        symptom: 'Wohlbefinden',
                                        index: index,
                                        averageSymptom:
                                            'avg(symptoms.wellbeing)',
                                        symptomsValue:
                                            allIngredientsWithSymptoms[index]
                                                ['avg(symptoms.wellbeing)'],
                                        allIngredientsWithSymptoms:
                                            allIngredientsWithSymptoms),
                                    SymptomsRow(
                                        symptom: 'Krämpfe',
                                        index: index,
                                        averageSymptom: 'avg(symptoms.cramps)',
                                        symptomsValue:
                                            allIngredientsWithSymptoms[index]
                                                ['avg(symptoms.cramps)'],
                                        allIngredientsWithSymptoms:
                                            allIngredientsWithSymptoms),
                                    SymptomsRow(
                                        symptom: 'Blähungen',
                                        index: index,
                                        averageSymptom:
                                            'avg(symptoms.flatulence)',
                                        symptomsValue:
                                            allIngredientsWithSymptoms[index]
                                                ['avg(symptoms.flatulence)'],
                                        allIngredientsWithSymptoms:
                                            allIngredientsWithSymptoms),
                                    SymptomsRow(
                                        symptom: 'Stuhlgang',
                                        index: index,
                                        averageSymptom: 'avg(symptoms.bowel)',
                                        symptomsValue:
                                            allIngredientsWithSymptoms[index]
                                                ['avg(symptoms.bowel)'],
                                        allIngredientsWithSymptoms:
                                            allIngredientsWithSymptoms),
                                  ],
                                ),
                              ),
                              ExpansionTile(
                                title: Text(
                                  "Mahlzeiten mit dieser Zutat",
                                  style: mySliderTextStyle(),
                                ),
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: mealCounter = getMealListLength(
                                        allIngredientsWithSymptoms[index]
                                            ['ingredient'], mealsFromIngredients),
                                    itemBuilder: (context, index2) {
                                      return Container(
                                        padding: EdgeInsets.fromLTRB(
                                            left, 0, right, bottom),
                                        child: Text(getMealsForIngredient(
                                            index2,
                                            allIngredientsWithSymptoms[index]
                                                ['ingredient'], mealsFromIngredients)),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  customCheckbox(String title, bool boolValue) {
    return Container(
      decoration: noTeal(),
      child: CheckboxListTile(
        title: Text(title),
        controlAffinity: ListTileControlAffinity.trailing,
        value: boolValue,
        onChanged: (bool? value) {
          /// manage the state of each value
          setState(() async {
            switch (title) {
              case "Alle anzeigen":
                allIsChecked = value!;
                setCheckboxStateDigestible("Alle anzeigen", value);
                allIngredientsWithSymptoms = await getAverageForSymptoms();
                break;
              case "Warnungen anzeigen":
                warningsIsChecked = value!;
                setCheckboxStateDigestible("Warnungen anzeigen", value);
                break;
              case "Verträgliche anzeigen":
                digestibleIsChecked = value!;
                setCheckboxStateDigestible("Verträgliche anzeigen", value);
                break;
              case "Symptomfreie anzeigen":
                symptomFreeIsChecked = value!;
                setCheckboxStateDigestible("Symptomfreie anzeigen", value);
                break;
              case "Alle Zeiten":
                allTimeIsChecked = value!;
                setCheckboxStateTime("Alle Zeiten", value);
                break;
              case "Während der Mahlzeit":
                whileEating = value!;
                setCheckboxStateTime("Während der Mahlzeit", value);
                break;
              case "In der ersten Stunde":
                firstHour = value!;
                setCheckboxStateTime("In der ersten Stunde", value);
                break;
              case "Nach 2-5 Stunden":
                twoAndFive = value!;
                setCheckboxStateTime("Nach 2-5 Stunden", value);
                break;
              case "Nach 5 Stunden":
                afterFive = value!;
                setCheckboxStateTime("Nach 5 Stunden", value);
                break;
            }
          });
        },
      ),
    );
  }

  setCheckboxStateDigestible(String title, bool value) {
    if (title == "Alle anzeigen") {
      warningsIsChecked = value;
      digestibleIsChecked = value;
      symptomFreeIsChecked = value;
    } else if (title != "Alle anzeigen") {
      if (warningsIsChecked == false ||
          digestibleIsChecked == false ||
          symptomFreeIsChecked == false) {
        allIsChecked = false;
      } else if (warningsIsChecked == true &&
          digestibleIsChecked == true &&
          symptomFreeIsChecked == true) {
        allIsChecked = true;
      }
    }
  }

  setCheckboxStateTime(String title, bool value) {
    if (title == "Alle Zeiten") {
      whileEating = value;
      firstHour = value;
      twoAndFive = value;
      afterFive = value;
    } else if (title != "Alle anzeigen") {
      if (whileEating == false ||
          firstHour == false ||
          twoAndFive == false ||
          afterFive == false) {
        allTimeIsChecked = false;
      } else if (whileEating == true &&
          firstHour == true &&
          twoAndFive == true &&
          afterFive == true) {
        allTimeIsChecked = true;
      }
    }
  }
}
