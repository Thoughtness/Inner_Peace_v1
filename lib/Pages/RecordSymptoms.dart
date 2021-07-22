import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Database/DatabaseHelper.dart';
import 'package:inner_peace_v1/Database/SymptomData.dart';
import 'package:inner_peace_v1/Database/SymptomsIngredientData.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/Pages/RecordedMeals.dart';
import 'package:inner_peace_v1/GuiElements.dart';
import 'package:inner_peace_v1/Main.dart';

class RecordSymptoms extends StatefulWidget {
  @override
  State createState() => new _RecordSymptoms();
}

class _RecordSymptoms extends State<RecordSymptoms> {
  final double height = 20;
  double symptomTotal = 0;
  var generalWellbeing1;
  double generalWellbeing = 0;
  double cramps = 0;
  double flatulence = 0;
  double bowel = 0;
  double sliderHeight = 15.0;
  double sliderWidth = 10.0;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.teal[100],
        endDrawer: menu(),
        appBar: AppBar(
          title: Text(
            'Symptome erfassen',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.cyanAccent,
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image(
                image: AssetImage('assets/Inner_Peace.png'),
                fit: BoxFit.fill,
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: sliderHeight),
                      Container(
                        height: 110,
                        decoration: myBoxDecoration(),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.cyanAccent,
                                border: Border.all(width: 1.0),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: sliderWidth),
                                  new Text(
                                    "Allgemeines Wohlbefinden",
                                    style: TextStyle(
                                      backgroundColor: Colors.cyanAccent,
                                      height: 1.5,
                                      fontSize: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Slider.adaptive(
                                    value: generalWellbeing,
                                    min: 0,
                                    max: 10,
                                    divisions: 10,
                                    activeColor: Colors.cyanAccent,
                                    onChanged: (double changedValue) {
                                      setState(() {
                                        generalWellbeing = changedValue;
                                      });
                                      print(generalWellbeing);
                                    },
                                    label: generalWellbeing.toString(),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(width: sliderWidth),
                                new Text(
                                  "Gut",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    height: 0.5,
                                    fontSize: 18,
                                  ),
                                ),
                                Spacer(),
                                new Text(
                                  "Schlecht",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    height: 0.5,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: sliderWidth),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: sliderHeight),
                      Container(
                        height: 110,
                        decoration: myBoxDecoration(),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.cyanAccent,
                                border: Border.all(width: 1.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: sliderWidth),
                                  new Text(
                                    "Krämpfe",
                                    style: TextStyle(
                                      backgroundColor: Colors.cyanAccent,
                                      height: 1.5,
                                      fontSize: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Slider.adaptive(
                                    value: cramps,
                                    min: 0,
                                    max: 10,
                                    divisions: 10,
                                    activeColor: Colors.cyanAccent,
                                    onChanged: (double changedValue) {
                                      setState(() {
                                        cramps = changedValue;
                                      });
                                      print(cramps);
                                    },
                                    label: cramps.toString(),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(width: sliderWidth),
                                new Text(
                                  "Keine",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    height: 0.5,
                                    fontSize: 18,
                                  ),
                                ),
                                Spacer(),
                                new Text(
                                  "Extrem",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    height: 0.5,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: sliderWidth),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: sliderHeight),
                      Container(
                        height: 110,
                        decoration: myBoxDecoration(),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.cyanAccent,
                                border: Border.all(width: 1.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: sliderWidth),
                                  new Text(
                                    "Blähungen",
                                    style: TextStyle(
                                      backgroundColor: Colors.cyanAccent,
                                      height: 1.5,
                                      fontSize: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Slider.adaptive(
                                    value: flatulence,
                                    min: 0,
                                    max: 10,
                                    divisions: 10,
                                    activeColor: Colors.cyanAccent,
                                    onChanged: (double changedValue) {
                                      setState(() {
                                        flatulence = changedValue;
                                      });
                                      print(flatulence);
                                    },
                                    label: flatulence.toString(),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(width: sliderWidth),
                                new Text(
                                  "Keine",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    height: 0.5,
                                    fontSize: 18,
                                  ),
                                ),
                                Spacer(),
                                new Text(
                                  "Extrem",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    height: 0.5,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: sliderWidth),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: sliderHeight),
                      Container(
                        height: 110,
                        decoration: myBoxDecoration(),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.cyanAccent,
                                border: Border.all(width: 1.0),
                                borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: sliderWidth),
                                  new Text(
                                    "Stuhlgang",
                                    style: TextStyle(
                                      backgroundColor: Colors.cyanAccent,
                                      height: 1.5,
                                      fontSize: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Slider.adaptive(
                                    value: bowel,
                                    min: 0,
                                    max: 10,
                                    divisions: 10,
                                    activeColor: Colors.cyanAccent,
                                    onChanged: (double changedValue) {
                                      setState(() {
                                        bowel = changedValue;
                                      });
                                      print(bowel);
                                    },
                                    label: bowel.toString(),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(width: sliderWidth),
                                new Text(
                                  "Fest",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    height: 0.5,
                                    fontSize: 18,
                                  ),
                                ),
                                Spacer(),
                                new Text(
                                  "Flüssig",
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    height: 0.5,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(width: sliderWidth),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //todo: make this scrollable (if phone is small so no overflow can occur)
                Spacer(),
                Container(
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        flex: 20,
                        child: CustomButton(
                          text: 'Keine Symptome',
                          onClick: () {
                            generalWellbeing = -10;
                            cramps = -10;
                            flatulence = -10;
                            bowel = -10;
                            addSymptoms();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RecordedMeals(),
                              ),
                            );
                          },
                        ),
                      ),
                      Flexible(
                        flex: 20,
                        child: CustomButton(
                          text: 'Symptome speichern',
                          onClick: () async {
                            addSymptoms();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RecordedMeals(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height),
              ],
            ),
          ],
        ),
      );

  Future addSymptoms() async {
    //Symptome in Tabelle einfügen
    var symptoms = SymptomData(
      generalWellbeing: generalWellbeing,
      cramps: cramps,
      flatulence: flatulence,
      bowel: bowel,
      symptomTotal: generalWellbeing + cramps + flatulence + bowel,
    );
    await DatabaseHelper.instance.insertSymptoms(symptoms);

    //letzte mealID herausholen
    var lastInsertedMeal = await DatabaseHelper.instance.getMealID();
    int mealID = lastInsertedMeal[0]['mealID'];

    //letze symptomsID herausholen
    var lastInsertedSymptoms = await DatabaseHelper.instance.getSymptomsID();
    int symptomsID = lastInsertedSymptoms[0]['symptomsID'];

    //symptomsIngredient erstellen
    var symptomsIngredient = SymptomsIngredientData(
        symptomsID: symptomsID,
        ingredientID: mealID
    );
    await DatabaseHelper.instance.createSymptomsIngredient(symptomsIngredient);
  }
}

