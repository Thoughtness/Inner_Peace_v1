import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Database/DatabaseFunctions.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/GuiElements.dart';
import 'package:inner_peace_v1/Pages/RecordSymptoms.dart';
import 'package:intl/intl.dart';
import 'package:inner_peace_v1/Formation and Elements/Formation.dart';

import 'RecordedMeals.dart';

class RecordMeal extends StatefulWidget {
  @override
  State createState() => new _RecordMeal();
}

class _RecordMeal extends State<RecordMeal> {
  var controller = TextEditingController();
  var mealName = TextEditingController();
  var ingredients = TextEditingController();

  List<String> ingredientList = [];
  List<double> amountList = [];

  TimeOfDay? time;
  String dateAndTime = '';
  String formatedDate = '';
  String? sqlFormatedDate;
  String? sqlFormatedTime;

  final double width = 10.0;
  final double containerWidth = 100.0;
  final double height = 10;
  final double boxDistance = 10;
  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 10.0;
  double amount = 5;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.teal[100],
        endDrawer: Menu(),
        appBar: AppBar(
          title: Text(
            'Mahlzeit erfassen',
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
              padding: EdgeInsets.fromLTRB(left, top, right, bottom),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, bottom),
                    decoration: thickDarkGrey(),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, right, 0),
                          width: containerWidth,
                          decoration: thinCyan(),
                          child: ListTile(
                            title: Text('Datum'),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: thinCyan(),
                            height: 58,
                            child: TextField(
                              enabled: false,
                              decoration: customInputDecoration('Datum / Uhrzeit'),
                              controller: controller,
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.calendar_today),
                            iconSize: 24.0,
                            color: Colors.grey,
                            onPressed: () async {
                              showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2019, 1),
                                  lastDate: DateTime(2021, 12),
                                  builder: (context, picker) {
                                    return datePicker(picker!);
                                  }).then((selectedDate) {
                                if (selectedDate != null) {
                                  formatedDate = DateFormat('dd.MM.yyyy').format(selectedDate);
                                  sqlFormatedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
                                  controller.text = formatedDate + ' ' + getText();
                                }
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.access_time_outlined),
                            iconSize: 24.0,
                            color: Colors.grey,
                            onPressed: () async {
                              final initialTime = TimeOfDay(hour: 9, minute: 0);
                              final newTime = await showTimePicker(
                                context: context,
                                initialTime: time ?? initialTime,
                              );
                              if (newTime == null) return;
                              setState(() => time = newTime);
                              sqlFormatedTime = getText();
                              controller.text = formatedDate + ' ' + getText();
                            }),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, bottom),
                    decoration: thickDarkGrey(),
                    child: CustomRow(
                      title: 'Gericht',
                      description: 'Gericht hier benennen',
                      textController: mealName,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, bottom),
                    decoration: thickDarkGrey(),
                    child: Column(
                      children: [
                        CustomRow(
                          title: 'Zutaten',
                          description: 'Zutaten einzeln hinzufügen',
                          textController: ingredients,
                        ),
                        SizedBox(height: height),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, right, 0),
                              width: containerWidth,
                              decoration: thinCyan(),
                              child: ListTile(
                                title: Text('Menge'),
                              ),
                            ),
                            Flexible(
                              flex: 29,
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 3,
                                    child: new Text(
                                      '-',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        height: 1,
                                        fontSize: 40,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 100,
                                    child: Slider.adaptive(
                                      value: amount,
                                      min: 0,
                                      max: 10,
                                      divisions: 10,
                                      activeColor: Colors.blue,
                                      onChanged: (double changedValue) {
                                        setState(() {
                                          amount = changedValue;
                                        });
                                      },
                                      label: amount.toString(),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: new Text(
                                      '+',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        height: 1,
                                        fontSize: 25,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Flexible(flex: 1, child: SizedBox(width: width)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (ingredients.text.length > 1) {
                        if (!ingredientList.contains(ingredients.text)) {
                          ingredientList.insert(0, ingredients.text);
                          amountList.insert(0, amount);
                        }
                      }
                      ingredients.clear();
                      setState(() {});
                    },
                    child: Text('Zutat hinzufügen'),
                    style: buttonStyle(),
                  ),
                  Flexible(
                    child: ListView.builder(
                      itemCount: ingredientList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 18,
                                fit: FlexFit.tight,
                                child: Container(
                                  decoration: thinGrey(),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(left, top, right, bottom),
                                    child: Text(
                                      ingredientList[index].toString(),
                                      style: TextStyle(fontSize: 20),
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 30,
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: amountList[index].toInt(),
                                      child: new Container(
                                        decoration: ingredientBar(index, amountList),
                                        height: 20.0,
                                      ),
                                    ),
                                    Flexible(
                                      flex: 10 - amountList[index].toInt(),
                                      child: SizedBox(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Flexible(
                          flex: 20,
                          child: CustomButton(
                            text: 'Symptome hinzufügen',
                            onClick: () async {
                              //Damit keine leeren Einträge gemacht werden können
                              if (mealName.text.length > 0 &&
                                  ingredientList.length > 0 &&
                                  sqlFormatedTime != '' &&
                                  sqlFormatedDate != null) {
                                int mealID = await addMealWithIngredients(sqlFormatedDate, sqlFormatedTime, ingredientList, mealName, amountList);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecordSymptoms(mealID: mealID),
                                  ),
                                );
                              }
                              //todo: Meldung machen, dass keine Zutat gespeichert ist
                            },
                          ),
                        ),
                        SizedBox(width: width),
                        Flexible(
                          flex: 20,
                          child: CustomButton(
                            text: 'Mahlzeit speichern',
                            onClick: () async {
                              //Damit keine leeren Einträge gemacht werden können
                              if (mealName.text.length > 0 &&
                                  ingredientList.length > 0 &&
                                  sqlFormatedTime != '' &&
                                  sqlFormatedDate != null) {
                                addMealWithIngredients(sqlFormatedDate, sqlFormatedTime, ingredientList, mealName, amountList);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RecordedMeals(),
                                  ),
                                );
                                //todo: 'Mahlzeit gespeichert' meldung erstellen
                              }
                              //todo: Meldung machen, dass keine Zutat gespeichert ist
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

  String getText() {
    try {
      final hours = time!.hour.toString().padLeft(2, '0');
      final minutes = time!.minute.toString().padLeft(2, '0');
      return '$hours:$minutes';
    } catch (e) {
      return '';
    }
  }
}

