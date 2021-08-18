import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/GuiElements.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/Formation and Elements/Formation.dart';
import 'package:inner_peace_v1/Formation and Elements/Functions.dart';
import 'package:inner_peace_v1/Database/DatabaseFunctions.dart';

class Intolerances extends StatefulWidget {
  Intolerances({
    required this.warnings,
    required this.digestible,
    required this.symptomFree,
    required this.mealsFromIngredients,
  });

  final List<Map<String, dynamic>> warnings;
  final List<Map<String, dynamic>> digestible;
  final List<Map<String, dynamic>> symptomFree;
  final List<Map<String, dynamic>> mealsFromIngredients;

  @override
  _Intolerances createState() => _Intolerances(
      warnings: warnings,
      digestible: digestible,
      symptomFree: symptomFree,
      mealsFromIngredients: mealsFromIngredients);
}

class _Intolerances extends State<Intolerances> {
  _Intolerances({
    required this.warnings,
    required this.digestible,
    required this.symptomFree,
    required this.mealsFromIngredients,
  });

  final List<Map<String, dynamic>> warnings;
  final List<Map<String, dynamic>> digestible;
  final List<Map<String, dynamic>> symptomFree;
  final List<Map<String, dynamic>> mealsFromIngredients;
  List<Map<String, dynamic>> allIngredientsWithSymptoms = [];

  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 10.0;

  String sortByFilter = "";
  String sort = 'Unverträglich';

  int symptomTimeLength = 0;
  bool allIsChecked = true;
  bool warningsIsChecked = true;
  bool digestibleIsChecked = true;
  bool symptomFreeIsChecked = true;

  @override
  Widget build(BuildContext context) {
    allIngredientsWithSymptoms = warnings + digestible + symptomFree;


    print(allIngredientsWithSymptoms);
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
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          this.left, this.top, this.right, 0),
                      child: Container(
                        decoration: thickTeal(),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  this.left, this.top, this.right, this.bottom),
                              decoration: thinCyan(),
                              child: Row(
                                children: [
                                  Text("Sortieren nach",
                                      style: myTextStyleMedium()),
                                ],
                              ),
                            ),
                            DropdownButton<String>(
                              value: sort,
                              icon: Icon(Icons.arrow_downward),
                              iconSize: 24,
                              elevation: 16,
                              style: myTextStyleSmall(),
                              underline: Container(
                                height: 2,
                                color: Colors.black,
                              ),
                              onChanged: (String? newValue) async {
                                sort = newValue!;
                                sortList();
                                setState(() {});
                              },
                              items: <String>[
                                'Unverträglich',
                                'Verträglich',
                                // 'Auftreten der Symptome ↑',
                                // 'Auftreten der Symptome ↓',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child:
                                      Text(value, style: myTextStyleMedium()),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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
                        style: myTextStyleMedium(),
                      ),
                      children: [
                        customCheckbox("Alle anzeigen", allIsChecked),
                        customCheckbox("Warnungen anzeigen", warningsIsChecked),
                        customCheckbox(
                            "Verträgliche anzeigen", digestibleIsChecked),
                        customCheckbox(
                            "Symptomfreie anzeigen", symptomFreeIsChecked),
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
                              padding: EdgeInsets.fromLTRB(
                                  this.left, this.top, this.right, this.bottom),
                              child: Column(
                                children: [
                                  SymptomsRow(
                                    barName: 'Wohlbefinden',
                                    //index: index,
                                    //barName: 'avg(symptoms.wellbeing)',
                                    value:
                                        allIngredientsWithSymptoms[index]
                                            ['avg(symptoms.wellbeing)'],
                                    allIngredientsWithSymptoms:
                                        allIngredientsWithSymptoms,
                                    barLength: barLengthSymptoms(
                                        allIngredientsWithSymptoms[index]
                                            ['avg(symptoms.wellbeing)']),
                                    opposingBarLength:
                                        opposingBarLengthSymptoms(
                                            allIngredientsWithSymptoms[index]
                                                ['avg(symptoms.wellbeing)']),
                                  ),
                                  SymptomsRow(
                                    barName: 'Krämpfe',
                                    //index: index,
                                    //barName: 'avg(symptoms.cramps)',
                                    value:
                                        allIngredientsWithSymptoms[index]
                                            ['avg(symptoms.cramps)'],
                                    allIngredientsWithSymptoms:
                                        allIngredientsWithSymptoms,
                                    barLength: barLengthSymptoms(
                                        allIngredientsWithSymptoms[index]
                                            ['avg(symptoms.cramps)']),
                                    opposingBarLength:
                                        opposingBarLengthSymptoms(
                                            allIngredientsWithSymptoms[index]
                                                ['avg(symptoms.cramps)']),
                                  ),
                                  SymptomsRow(
                                    barName: 'Blähungen',
                                    //index: index,
                                    //barName: 'avg(symptoms.flatulence)',
                                    value:
                                        allIngredientsWithSymptoms[index]['avg(symptoms.flatulence)'],
                                    allIngredientsWithSymptoms: allIngredientsWithSymptoms,
                                    barLength: barLengthSymptoms(allIngredientsWithSymptoms[index]['avg(symptoms.flatulence)']),
                                    //barLength: barLengthSymptoms(index, 'avg(symptoms.flatulence)', allIngredientsWithSymptoms),
                                    opposingBarLength:
                                        opposingBarLengthSymptoms(
                                            allIngredientsWithSymptoms[index]
                                                ['avg(symptoms.flatulence)']),
                                  ),
                                  SymptomsRow(
                                    barName: 'Stuhlgang',
                                    //index: index,
                                    //barName: 'avg(symptoms.bowel)',
                                    value:
                                        allIngredientsWithSymptoms[index]
                                            ['avg(symptoms.bowel)'],
                                    allIngredientsWithSymptoms:
                                        allIngredientsWithSymptoms,
                                    barLength: barLengthSymptoms(
                                        allIngredientsWithSymptoms[index]
                                            ['avg(symptoms.bowel)']),
                                    opposingBarLength:
                                        opposingBarLengthSymptoms(
                                            allIngredientsWithSymptoms[index]
                                                ['avg(symptoms.bowel)']),
                                  ),
                                ],
                              ),
                            ),
                            ExpansionTile(
                              title: Text(
                                "Auftreten der Symptome",
                                style: mySliderTextStyle(),
                              ),
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      this.left, 0, this.right, this.bottom),
                                  child: Column(
                                    children: [
                                      SymptomsRow(
                                        barName: 'Während der Mahlzeit',
                                        value: 11,
                                        allIngredientsWithSymptoms: allIngredientsWithSymptoms,
                                        barLength: symptomTimeLength = getSymptomTimeLength('Während der Mahlzeit', mealsFromIngredients, allIngredientsWithSymptoms[index]['ingredient']),
                                        opposingBarLength: getSymptomTimeTotalLength(mealsFromIngredients, allIngredientsWithSymptoms[index]['ingredient']) - symptomTimeLength,
                                      ),
                                      SymptomsRow(
                                        barName: 'In der ersten Stunde',
                                        value: 11,
                                        allIngredientsWithSymptoms: allIngredientsWithSymptoms,
                                        barLength: symptomTimeLength = getSymptomTimeLength('In der ersten Stunde', mealsFromIngredients, allIngredientsWithSymptoms[index]['ingredient']),
                                        opposingBarLength: getSymptomTimeTotalLength(mealsFromIngredients, allIngredientsWithSymptoms[index]['ingredient']) - symptomTimeLength,
                                      ),
                                      SymptomsRow(
                                        barName: 'Nach 2-5 Stunden',
                                        value: 11,
                                        allIngredientsWithSymptoms: allIngredientsWithSymptoms,
                                        barLength: symptomTimeLength = getSymptomTimeLength('Nach 2-5 Stunden', mealsFromIngredients, allIngredientsWithSymptoms[index]['ingredient']),
                                        opposingBarLength: getSymptomTimeTotalLength(mealsFromIngredients, allIngredientsWithSymptoms[index]['ingredient']) - symptomTimeLength,
                                      ),
                                      SymptomsRow(
                                        barName: 'Nach 5 Stunden',
                                        value: 11,
                                        allIngredientsWithSymptoms: allIngredientsWithSymptoms,
                                        barLength: symptomTimeLength = getSymptomTimeLength('Nach 5 Stunden', mealsFromIngredients, allIngredientsWithSymptoms[index]['ingredient']),
                                        opposingBarLength: getSymptomTimeTotalLength(mealsFromIngredients, allIngredientsWithSymptoms[index]['ingredient']) - symptomTimeLength,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                                  itemCount: getMealListLength(allIngredientsWithSymptoms[index]['ingredient'], mealsFromIngredients),
                                  itemBuilder: (context, index2) {
                                    return Container(
                                      padding: EdgeInsets.fromLTRB(
                                          left, 0, right, bottom),
                                      child: Text(getMealsForIngredient(
                                          index2,
                                          allIngredientsWithSymptoms[index]
                                              ['ingredient'],
                                          mealsFromIngredients)),
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
          switch (title) {
            case "Alle anzeigen":
              allIsChecked = value!;
              warningsIsChecked = value;
              digestibleIsChecked = value;
              symptomFreeIsChecked = value;
              if (allIsChecked == true) {
                allIngredientsWithSymptoms =
                    warnings + digestible + symptomFree;
                break;
              }
              allIngredientsWithSymptoms = [];
              break;
            case "Warnungen anzeigen":
              warningsIsChecked = value!;
              setCheckboxState("Warnungen anzeigen", value);
              getIngredients(warningsIsChecked, digestibleIsChecked,
                  symptomFreeIsChecked, warnings, digestible, symptomFree);
              break;
            case "Verträgliche anzeigen":
              digestibleIsChecked = value!;
              setCheckboxState("Verträgliche anzeigen", value);
              getIngredients(digestibleIsChecked, warningsIsChecked,
                  symptomFreeIsChecked, digestible, warnings, symptomFree);
              break;
            case "Symptomfreie anzeigen":
              symptomFreeIsChecked = value!;
              setCheckboxState("Symptomfreie anzeigen", value);
              getIngredients(symptomFreeIsChecked, warningsIsChecked,
                  digestibleIsChecked, symptomFree, warnings, digestible);
              break;
          }
          setState(() {});
        },
      ),
    );
  }

  getIngredients(
      bool primary,
      bool secondary1,
      secondary2,
      List<Map<String, dynamic>> primaryList,
      List<Map<String, dynamic>> secondaryList1,
      List<Map<String, dynamic>> secondaryList2) {
    if (primary) {
      allIngredientsWithSymptoms = primaryList;
      if (allIsChecked) {
        allIngredientsWithSymptoms =
            primaryList + secondaryList1 + secondaryList2;
      } else if (secondary1) {
        allIngredientsWithSymptoms = primaryList + secondaryList1;
      } else if (secondary2) {
        allIngredientsWithSymptoms = primaryList + secondaryList2;
      }
    } else if (!primary && secondary1 && secondary2) {
      allIngredientsWithSymptoms = secondaryList1 + secondaryList2;
    } else if (!primary && secondary1) {
      allIngredientsWithSymptoms = secondaryList1;
    } else if (!primary && secondary2) {
      allIngredientsWithSymptoms = secondaryList2;
    } else if (!primary && !secondary1 && !secondary2) {
      allIngredientsWithSymptoms = [];
    }
    sortList();
  }

  sortList() {
    if (sort == "Unverträglich") {
      allIngredientsWithSymptoms.sort((a, b) => b["sum(symptoms.symptomTotal)"]
          .compareTo(a["sum(symptoms.symptomTotal)"]));
    } else if (sort == "Verträglich") {
      allIngredientsWithSymptoms.sort((a, b) => a["sum(symptoms.symptomTotal)"]
          .compareTo(b["sum(symptoms.symptomTotal)"]));
    }
    return allIngredientsWithSymptoms;
  }

  setCheckboxState(String title, bool value) {
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