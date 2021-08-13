import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/GuiElements.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/Formation and Elements/Formation.dart';
import 'package:inner_peace_v1/Database/DatabaseFunctions.dart';

class RecordedMeals extends StatefulWidget {
  @override
  State createState() => new _RecordedMeals();
}

class _RecordedMeals extends State<RecordedMeals> {
  List<Map<String, dynamic>> mealList = [];

  String sort = 'Mahlzeitdatum';
  String sortByFilter = "";
  String? filter = 'Keine';
  double filterNumberLow = 0;
  double filterNumberHigh = 0;
  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 10.0;
  final double width = 10.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      endDrawer: Menu(),
      appBar: AppBar(
        title: Text(
          'Erfasste Mahlzeiten',
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
              Container(
                padding: EdgeInsets.fromLTRB(
                    this.left, this.top, this.right, this.bottom),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 170,
                      decoration: thickTeal(),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                this.left, this.top, this.right, this.bottom),
                            decoration: thinCyan(),
                            child: Row(
                              children: [
                                Text("Mahlzeittyp wählen"),
                              ],
                            ),
                          ),
                          DropdownButton<String>(
                            value: filter,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: myTextStyleSmall(),
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            onChanged: (String? newValue) async {
                              filter = newValue;
                              mealList = await getMealList(newValue, sort);
                              setState(() {});
                            },
                            items: <String>[
                              'Keine',
                              'Alle',
                              'Symptomfrei',
                              'Verträglich',
                              'Unverträglich'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: SizedBox(width: 100),
                    ),
                    Container(
                      width: 170,
                      decoration: thickTeal(),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                this.left, this.top, this.right, this.bottom),
                            decoration: thinCyan(),
                            child: Row(
                              children: [
                                Text("Sortierung wählen"),
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
                            onChanged: (String? newValue) async{
                              sort = newValue!;
                              mealList = await getMealList(filter, newValue);
                                setState((){});
                            },
                            items: <String>[
                              'Mahlzeitdatum',
                              'Name A-Z',
                              'Name Z-A',
                              'Verträglichkeit',
                              'Unverträglichkeit'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  itemCount: mealList.length,
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
                                        mealList[index]['meal'].toString(),
                                        style: myTitleCyanAccentTextStyle()),
                                  ),
                                  Spacer(),
                                  //todo add info button (popup with all info)
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      iconSize: 24.0,
                                      color: Colors.grey,
                                      onPressed: () async {
                                        //todo: make popup "are you sure" to delete meal (make separate mehtod with the popup, when select yes then call deleteMeal
                                        await deleteMeal(mealList[index]['mealID']);
                                        setState(() async {
                                          mealList = await getMealList(filter, sort);
                                          setState(() {});
                                        });
                                      }),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(
                                  this.left, this.top, this.right, this.bottom),
                              child: Column(
                                children: [
                                  SymptomsRow(
                                      symptom: 'Wohlbefinden',
                                      index: index,
                                      averageSymptom: 'wellbeing',
                                      symptomsValue: mealList[index]['wellbeing'],
                                      allIngredientsWithSymptoms: mealList),
                                  SymptomsRow(
                                      symptom: 'Krämpfe',
                                      index: index,
                                      averageSymptom: 'cramps',
                                      symptomsValue: mealList[index]['cramps'],
                                      allIngredientsWithSymptoms: mealList),
                                  SymptomsRow(
                                      symptom: 'Blähungen',
                                      index: index,
                                      averageSymptom: 'flatulence',
                                      symptomsValue: mealList[index]['flatulence'],
                                      allIngredientsWithSymptoms: mealList),
                                  SymptomsRow(
                                      symptom: 'Stuhlgang',
                                      index: index,
                                      averageSymptom: 'bowel',
                                      symptomsValue: mealList[index]['bowel'],
                                      allIngredientsWithSymptoms: mealList),
                                ],
                              ),
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
}
