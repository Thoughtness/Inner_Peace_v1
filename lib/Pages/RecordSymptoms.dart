import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Database/DatabaseHelper.dart';
import 'package:inner_peace_v1/Database/SymptomData.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/Pages/RecordedMeals.dart';
import 'package:inner_peace_v1/GuiElements.dart';
import 'package:inner_peace_v1/Main.dart';

class RecordSymptoms extends StatefulWidget {
  // final String mealID;
  //
  // RecordSymptoms({Key key, this.mealID,}) : super (key: key);

  @override
  State createState() => new _RecordSymptoms();
}

class _RecordSymptoms extends State<RecordSymptoms> {

  // var mealID = widget.value;

  final double height = 20;
  var generalWellbeing1;
  double generalWellbeing = 0;
  double cramps = 0;
  double flatulence = 0;
  double bowel = 0;
  double sliderHeight = 15.0;
  double sliderWidth = 10.0;
  double negativeCounter = -10;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.teal[100],
        endDrawer: menu(),
        appBar: AppBar(
          title: Text(
            'Symptome erfassen',
            style: myAppBarTextStyle(),
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
                                    style: myTitleCyanAccentTextStyle(),
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
                                  style: mySliderTextStyle(),
                                ),
                                Spacer(),
                                new Text(
                                  "Schlecht",
                                  textAlign: TextAlign.right,
                                  style: mySliderTextStyle(),
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
                                    style: myTitleCyanAccentTextStyle(),
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
                                  style: mySliderTextStyle(),
                                ),
                                Spacer(),
                                new Text(
                                  "Extrem",
                                  textAlign: TextAlign.right,
                                  style: mySliderTextStyle(),
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
                                    style: myTitleCyanAccentTextStyle(),
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
                                  style: mySliderTextStyle(),
                                ),
                                Spacer(),
                                new Text(
                                  "Extrem",
                                  textAlign: TextAlign.right,
                                  style: mySliderTextStyle(),
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
                                    style: myTitleCyanAccentTextStyle(),
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
                                  style: mySliderTextStyle(),
                                ),
                                Spacer(),
                                new Text(
                                  "Flüssig",
                                  textAlign: TextAlign.right,
                                  style: mySliderTextStyle(),
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
                            addSymptoms(negativeCounter, negativeCounter, negativeCounter, negativeCounter);
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
                            addSymptoms(generalWellbeing, cramps, flatulence, bowel);
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

  Future addSymptoms(double generalWellbeing, double cramps, double flatulence, double bowel) async {
    //Multiplikator für Symptome = je schlimmer die Symptome desto höher der Multiplikator ( eine 10 ist wesentlich schlimmer wie 4* eine 3)
    List<double> symptomList = [generalWellbeing, cramps, flatulence, bowel];

    for(int i = 0; i <= 3; i++){
      if(symptomList[i] == 6){
        symptomList[i] = symptomList[i] * 1.25;
      }else if(symptomList[i] == 7){
        symptomList[i] = symptomList[i] * 1.5;
      }else if(symptomList[i] == 8){
        symptomList[i] = symptomList[i] * 2;
      }else if(symptomList[i] == 9){
        symptomList[i] = symptomList[i] * 2.75;
      }else if(symptomList[i] == 10){
        symptomList[i] = symptomList[i] * 4;
      }
    }

    //Symptome in Tabelle einfügen
    var symptoms = SymptomData(
      generalWellbeing: generalWellbeing,
      cramps: cramps,
      flatulence: flatulence,
      bowel: bowel,
      symptomTotal: symptomList[0] + symptomList[1] + symptomList[2] + symptomList[3],
    );
    await DatabaseHelper.instance.insertSymptoms(symptoms);

    //letzte mealID herausholen
    //todo: nicht höchste mealID suchen sondern mitgabe damit bei späterem hinzufügen keine Probleme entstehen
    var lastInsertedMeal = await DatabaseHelper.instance.getHighestMealID();
    int mealID = lastInsertedMeal[0]['mealID'];
    print(mealID);

    //letze symptomsID herausholen
    var lastInsertedSymptoms = await DatabaseHelper.instance.getSymptomsID();
    int symptomsID = lastInsertedSymptoms[0]['symptomsID'];

    await DatabaseHelper.instance.addSymptomsToMeal(symptomsID, mealID);
  }
}

