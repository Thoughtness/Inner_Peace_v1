import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/GuiElements.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/Formation and Elements/Formation.dart';
import 'package:inner_peace_v1/Formation and Elements/Functions.dart';
import 'package:inner_peace_v1/Database/DatabaseFunctions.dart';

class RecordedMeals extends StatefulWidget {
  @override
  State createState() => new _RecordedMeals();
}

class _RecordedMeals extends State<RecordedMeals> {
  List<Map<String, dynamic>> mealList = [];

  String sort = 'Mahlzeitdatum';
  String sortByFilter = '';
  String filter = 'Keine';
  double filterNumberLow = 0;
  double filterNumberHigh = 0;
  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 10.0;
  final double width = 10.0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                  padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          decoration: thickGrey(),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                                decoration: thinCyan(),
                                child: Row(
                                  children: [
                                    Text('Mahlzeittyp wählen', style: myTextStyleMedium()),
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
                                  filter = newValue!;
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
                                    child: Text(value, style: myTextStyleMedium()),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Container(
                          decoration: thickGrey(),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                                decoration: thinCyan(),
                                child: Row(
                                  children: [
                                    Text('Sortierung wählen', style: myTextStyleMedium()),
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
                                  mealList = await getMealList(filter, newValue);
                                  setState(() {});
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
                                    child: Text(value, style: myTextStyleMedium()),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
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
                          decoration: thickGrey(),
                          child: Column(
                            children: [
                              Container(
                                decoration: thinCyan(),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(left, 0, 0, bottom),
                                        child: FittedBox(
                                          alignment: Alignment.topLeft,
                                          fit: BoxFit.scaleDown,
                                          child: Text(mealList[index]['meal'].toString(),
                                              style: myTitleCyanAccentTextStyle()),
                                        ),
                                      ),
                                    ),
                                    //todo add info button (popup with all info)
                                    IconButton(
                                        icon: Icon(Icons.delete),
                                        iconSize: 24.0,
                                        color: Colors.grey,
                                        onPressed: () async {
                                          //todo: make popup 'are you sure' to delete meal (make separate mehtod with the popup, when select yes then call deleteMeal
                                          await deleteMeal(
                                              mealList[index]['mealID']);
                                          setState(() async {
                                            mealList =
                                                await getMealList(filter, sort);
                                            setState(() {});
                                          });
                                        }),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                                child: Column(
                                  children: [
                                    SymptomsRow(
                                      barName: 'Wohlbefinden',
                                      color: barColorMeal(mealList[index]['wellbeing']),
                                      allIngredientsWithSymptoms: mealList,
                                      barLength: barLengthSymptoms(mealList[index]['wellbeing']),
                                      opposingBarLength: opposingBarLengthSymptomsMeal(mealList[index]['wellbeing']),
                                    ),
                                    SymptomsRow(
                                      barName: 'Krämpfe',
                                      color: barColorMeal(mealList[index]['cramps']),
                                      allIngredientsWithSymptoms: mealList,
                                      barLength: barLengthSymptoms(mealList[index]['cramps']),
                                      opposingBarLength: opposingBarLengthSymptomsMeal(mealList[index]['cramps']),
                                    ),
                                    SymptomsRow(
                                      barName: 'Blähungen',
                                      color: barColorMeal(mealList[index]['flatulence']),
                                      allIngredientsWithSymptoms: mealList,
                                      barLength: barLengthSymptoms(mealList[index]['flatulence']),
                                      opposingBarLength: opposingBarLengthSymptomsMeal(mealList[index]['flatulence']),
                                    ),
                                    SymptomsRow(
                                      barName: 'Stuhlgang',
                                      color: barColorMeal(mealList[index]['bowel']),
                                      allIngredientsWithSymptoms: mealList,
                                      barLength: barLengthSymptoms(mealList[index]['bowel']),
                                      opposingBarLength: opposingBarLengthSymptomsMeal(mealList[index]['bowel']),
                                    ),
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
      ),
    );
  }
}
