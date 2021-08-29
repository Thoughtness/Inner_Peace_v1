import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Database/DatabaseFunctions.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/Pages/RecordedMeals.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/GuiElements.dart';
import 'package:inner_peace_v1/Formation and Elements/Formation.dart';

class RecordSymptoms extends StatefulWidget {
  RecordSymptoms({
    required this.mealID,
  });
  final int mealID;

  @override
  State createState() => new _RecordSymptoms(mealID: mealID);
}

class _RecordSymptoms extends State<RecordSymptoms> {
  _RecordSymptoms({required this.mealID});

  final int mealID;
  String sort = 'Während der Mahlzeit';
  double wellbeing = 0;
  double cramps = 0;
  double flatulence = 0;
  double bowel = 0;

  final double boxDistance = 10;
  final double width = 10.0;
  final double negativeCounter = -20;
  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 10.0;

  @override
  Widget build(BuildContext context) {
    //WillPopScope: verhindert das der Back button verwendet werden kann
  return WillPopScope(
    onWillPop: () async => false,
    child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.teal[100],
          endDrawer: Menu(),
          appBar: AppBar(
            title: Text(
              'Symptome erfassen',
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
              Padding(
                padding: EdgeInsets.fromLTRB(
                    left, top, right, bottom),
                child: Column(
                  children: [
                    Expanded(
                      //für kleinere Bildschirme, damit die Slider nicht über den Bildschirm hinausgehen
                      child: ListView(
                        children: [
                          Container(
                            decoration: thickGrey(),
                            child: Column(
                              children: [
                                Container(
                                  decoration: thinCyan(),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(left, 0, 0, 0),
                                        child: Text("Auftreten der Symptome",
                                            style: myTitleCyanAccentTextStyle()),
                                      ),
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
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      sort = newValue!;
                                    });
                                  },
                                  items: <String>[
                                    'Während der Mahlzeit',
                                    'In der ersten Stunde',
                                    'Nach 2-5 Stunden',
                                    'Nach 5 Stunden',
                                  ].map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: mySliderTextStyle(),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: boxDistance),
                          customSlider("Wohlbefinden", wellbeing, "Gut", "Schlecht"),
                          SizedBox(height: boxDistance),
                          customSlider("Krämpfe", cramps, "Keine", "Extrem"),
                          SizedBox(height: boxDistance),
                          customSlider("Blähungen", flatulence, "Keine", "Extrem"),
                          SizedBox(height: boxDistance),
                          customSlider("Stuhlgang", bowel, "Fest", "Flüssig"),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: [
                          Flexible(
                            flex: 20,
                            child: CustomButton(
                              text: 'Keine Symptome',
                              onClick: () {
                                addSymptoms(negativeCounter, negativeCounter,
                                    negativeCounter, negativeCounter, mealID, "Keine");
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RecordedMeals(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(width: width),
                          Flexible(
                            flex: 20,
                            child: CustomButton(
                              text: 'Symptome speichern',
                              onClick: () async {
                                addSymptoms(wellbeing, cramps, flatulence,
                                    bowel, mealID, sort);
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
                  ],
                ),
              ),
            ],
          ),
        ),
);
  }

  customSlider(String title, double value, String good, String bad) {
    return Container(
      height: 110,
      decoration: thickGrey(),
      child: Column(
        children: [
          Container(
            decoration: thinCyan(),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(left, 0, 0, 0),
                  child: Text(
                    title,
                    style: myTitleCyanAccentTextStyle(),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Slider.adaptive(
                  value: value,
                  min: 0,
                  max: 10,
                  divisions: 10,
                  activeColor: Colors.cyanAccent,
                  onChanged: (double changedValue) {
                    setState(() {
                      switch (title){
                        case "Wohlbefinden":
                          wellbeing = changedValue;
                          break;
                        case "Krämpfe":
                          cramps = changedValue;
                          break;
                        case "Blähungen":
                          flatulence = changedValue;
                          break;
                        case "Stuhlgang":
                          bowel = changedValue;
                          break;
                      }
                    });
                  },
                  label: value.toString(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(width: width),
              Text(
                good,
                textAlign: TextAlign.left,
                style: mySliderTextStyle(),
              ),
              Spacer(),
              Text(
                bad,
                textAlign: TextAlign.right,
                style: mySliderTextStyle(),
              ),
              SizedBox(width: width),
            ],
          ),
        ],
      ),
    );
  }
}