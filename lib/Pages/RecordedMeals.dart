import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Database/IngredientData.dart';
import 'package:inner_peace_v1/Database/MealData.dart';
import 'package:inner_peace_v1/GuiElements.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/Database/DatabaseHelper.dart';

class RecordedMeals extends StatefulWidget {
  @override
  State createState() => new _RecordedMeals();
}

class _RecordedMeals extends State<RecordedMeals> {
  List<Map<String, dynamic>> mealList = [];

  String sort = 'Erfassungsdatum';
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
      endDrawer: menu(),
      appBar: AppBar(
        title: Text(
          'Erfasste Mahlzeiten',
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
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                    this.left, this.top, this.right, this.bottom),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 170,

                      decoration: myBoxDecoration(),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                this.left, this.top, this.right, this.bottom),
                            decoration: myInnerBoxDecoration(),
                            child: Row(
                              children: [
                                Text("Mahlzeittyp wählen"),
                              ],
                            ),),
                          DropdownButton<String>(
                            value: filter,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: myTextStyle(),
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            onChanged: (String? newValue) {
                              getMealList(newValue, sort);
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
                      decoration: myBoxDecoration(),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(
                                this.left, this.top, this.right, this.bottom),
                              decoration: myInnerBoxDecoration(),
                              child: Row(
                                children: [
                                  Text("Sortierung wählen"),
                                ],
                              ),),

                          DropdownButton<String>(
                            value: sort,
                            icon: Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: myTextStyle(),
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                sort = newValue!;
                                getMealList(filter, newValue);
                              });
                            },
                            items: <String>[
                              'Erfassungsdatum',
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
                        decoration: myBoxDecoration(),
                        child: Column(
                          children: <Widget>[
                            Container(
                              decoration: myInnerBoxDecoration(),
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
                                    color: Colors.red,
                                    onPressed: () async {
                                      deleteMeal(index);
                                    }
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 150,
                                          child: Text('Allg. Wohlbefinden'),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Flexible(
                                                flex: barLength(
                                                    index, 'generalWellbeing'),
                                                child: new Container(
                                                  decoration: BoxDecoration(
                                                    color: barColor(mealList[index]
                                                            ['generalWellbeing']
                                                        .toInt()),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(20.0)),
                                                  ),
                                                  height: 20.0,
                                                ),
                                              ),
                                              Flexible(
                                                flex: opposingBarLength(
                                                    index, 'generalWellbeing'),
                                                child: SizedBox(),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 150,
                                          child: Text('Krämpfe'),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Flexible(
                                                flex: barLength(index, 'cramps'),
                                                child: new Container(
                                                  decoration: BoxDecoration(
                                                    color: barColor(mealList[index]
                                                            ['cramps']
                                                        .toInt()),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(20.0)),
                                                  ),
                                                  height: 20.0,
                                                ),
                                              ),
                                              Flexible(
                                                flex: opposingBarLength(
                                                    index, 'cramps'),
                                                child: SizedBox(),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 150,
                                          child: Text('Blähungen'),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Flexible(
                                                flex:
                                                    barLength(index, 'flatulence'),
                                                child: new Container(
                                                  decoration: BoxDecoration(
                                                    color: barColor(mealList[index]
                                                            ['flatulence']
                                                        .toInt()),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(20.0)),
                                                  ),
                                                  height: 20.0,
                                                ),
                                              ),
                                              Flexible(
                                                flex: opposingBarLength(
                                                    index, 'flatulence'),
                                                child: SizedBox(),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 3),
                                    child: Row(
                                      children: <Widget>[
                                        Container(
                                          width: 150,
                                          child: Text('Stuhlgang'),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Flexible(
                                                flex: barLength(index, 'bowel'),
                                                child: new Container(
                                                  decoration: BoxDecoration(
                                                    color: barColor(mealList[index]
                                                            ['bowel']
                                                        .toInt()),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(20.0)),
                                                  ),
                                                  height: 20.0,
                                                ),
                                              ),
                                              Flexible(
                                                flex: opposingBarLength(
                                                    index, 'bowel'),
                                                child: SizedBox(),
                                              ),
                                            ],
                                          ),
                                        )
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
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  getMealList(String? value, String? sort) async {
    mealList = [];
    var mealCount = await DatabaseHelper.instance.getHighestMealID();
    int numbOfMeals = mealCount[0]['mealID'];
    print(numbOfMeals);
    if (value == 'Alle') {
      for (int i = 1; i <= numbOfMeals; i++) {
        try {
          print(i);
        var meal = await DatabaseHelper.instance.getAllRecordedMeals(i);
          //var meals = await DatabaseHelper.instance.getAllRecordedMeals2(i);
          // var meals2 = await DatabaseHelper.instance.getAllRecordedMeals3(i);
          // var meals = await DatabaseHelper.instance.getMeal();
          //print(meals);
          // print(meals2);
        mealList.add(meal[0]);
        //print(meal[0]);
        } catch (e) {
          //Handle exception of type SomeException
        }
      }
    } else if (value == "Symptomfrei") {
      filterNumberLow = -11;
      filterNumberHigh = -9;
      for (int i = 1; i <= numbOfMeals; i++) {
        try {
          var meal = await DatabaseHelper.instance
              .getCertainRecordedMeals(i, filterNumberLow, filterNumberHigh);
          mealList.add(meal[0]);
        } catch (e) {
          //Handle exception of type SomeException
        }
      }
    } else if (value == "Verträglich") {
      filterNumberLow = 0;
      filterNumberHigh = 6;
      for (int i = 1; i <= numbOfMeals; i++) {

        try {
          var meal = await DatabaseHelper.instance
              .getCertainRecordedMeals(i, filterNumberLow, filterNumberHigh);
          mealList.add(meal[0]);
        } catch (e) {
          //Handle exception of type SomeException
        }
      }
    } else if (value == "Unverträglich") {
      filterNumberLow = 7;
      for (int i = 1; i <= numbOfMeals; i++) {
        try {
          var meal = await DatabaseHelper.instance
              .getIntolerantRecordedMeals(i, filterNumberLow);
          mealList.add(meal[0]);
        } catch (e) {
          //Handle exception of type SomeException
        }
      }
    }

    if (sort == "Erfassungsdatum") {
      mealList.sort((a, b) => a["mealID"].compareTo(b["mealID"]));
    } else if (sort == "Name A-Z") {
      mealList.sort((a, b) => a["meal"].compareTo(b["meal"]));
    } else if (sort == "Name Z-A") {
      mealList.sort((a, b) => b["meal"].compareTo(a["meal"]));
    } else if (sort == "Verträglichkeit") {
      mealList.sort((a, b) => a["symptomTotal"].compareTo(b["symptomTotal"]));
    } else if (sort == "Unverträglichkeit") {
      mealList.sort((a, b) => b["symptomTotal"].compareTo(a["symptomTotal"]));
    }

    setState(() {
      filter = value!;
    });
  }

  Future deleteMeal(int index) async{
    print(index);
    index = index + 1;
    var deleteMealInformation = await DatabaseHelper.instance.getDeleteMealInformation(index);
    print(deleteMealInformation);

    // await DatabaseHelper.instance.deleteMeal("meal", "mealID", deleteMealInformation[0]['mealID']);
    //   await DatabaseHelper.instance.deleteMeal("mealingredient", "mealID", deleteMealInformation[0]['mealID']);
    //   await DatabaseHelper.instance.deleteMeal("symptomsingredient", "ingredientID", deleteMealInformation[0]['ingredientID']);
    //   await DatabaseHelper.instance.deleteMeal("mealID", "mealID", deleteMealInformation[0]['mealID']);

    var mealingredientID = await DatabaseHelper.instance.getMealIngredient(index);
    print(mealingredientID.toString());
    // //for (int i = 0; mealingredientID[i]['mealIngredientID'] != null; i++){
    // for (int i = 0; i < mealingredientID.length; i++){
    //   var ingredientID = await DatabaseHelper.instance.getIngredientID(mealingredientID[i]['ingredientID']);
    // }
    // for (int i = 0; i>= mealingredientID.length(); i++) {
    //
    // }

    //await DatabaseHelper.instance.deleteMeal(index);
    setState(() {
    });
  }

  barLength(int index, String symptom) {
    int barLength = mealList[index]['$symptom'].round();
    return barLength;
  }

  opposingBarLength(int index, String symptom) {
    int barLength = mealList[index]['$symptom'].round();
    int opposingBarLength = 10 - barLength;
    return opposingBarLength;
  }

  barColor(int index) {
    Color color = Colors.purple;

    if (index <= 3) {
      color = Colors.green;
    } else if (index <= 5) {
      color = Colors.yellow;
    } else if (index <= 8) {
      color = Colors.orange;
    } else if (index <= 10) {
      color = Colors.red;
    }
    return color;
  }
}
