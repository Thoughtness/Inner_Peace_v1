import 'package:flutter/material.dart';
import 'package:inner_peace_v1/Database/DatabaseFunctions.dart';
import 'package:inner_peace_v1/Pages/Main.dart';
import 'package:inner_peace_v1/Pages/NavigationMenu.dart';
import 'package:inner_peace_v1/Formation%20and%20Elements/GuiElements.dart';
import 'package:inner_peace_v1/Pages/RecordSymptoms.dart';
import 'package:intl/intl.dart';
import 'package:inner_peace_v1/Formation and Elements/Formation.dart';

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
  String dateAndTime = "";
  String formatedDate = "";
  String? sqlFormatedDate;
  String? sqlFormatedTime;

  final double width = 10.0;
  final double containerWidth = 100.0;
  final double height = 10;
  final double boxDistance = 10;
  final double left = 10.0;
  final double top = 10.0;
  final double right = 10.0;
  final double bottom = 0.0;
  double amount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  decoration: thickTeal(),
                  child: Row(
                    children: [
                      Container(
                        width: containerWidth,
                        decoration: thinCyan(),
                        child: ListTile(
                          title: Text("Datum"),
                        ),
                      ),
                      SizedBox(width: width),
                      Expanded(
                        child: Container(
                          decoration: thinCyan(),
                          height: 58,
                          child: TextField(
                            enabled: false,
                            decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                border: OutlineInputBorder(),
                                hintText: "Datum und Uhrzeit wählen"),
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
                                formatedDate = DateFormat('dd.MM.yyyy')
                                    .format(selectedDate);
                                sqlFormatedDate = DateFormat('yyyy-MM-dd')
                                    .format(selectedDate);
                                controller.text =
                                    formatedDate + " " + getText();
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
                            controller.text = formatedDate + " " + getText();
                          }),
                    ],
                  ),
                ),
                SizedBox(height: boxDistance),
                Container(
                  decoration: thickTeal(),
                  //padding: EdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom),
                  child: CustomRow(
                    title: 'Gericht',
                    description: 'Gericht hier benennen',
                    textController: mealName,
                  ),
                ),
                SizedBox(height: boxDistance),
                Container(
                  decoration: thickTeal(),
                  child: Column(
                    children: [
                      Container(
                        //padding: EdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom),
                        child: CustomRow(
                          title: 'Zutaten',
                          description: 'Zutaten einzeln hinzufügen',
                          textController: ingredients,
                        ),
                      ),
                      SizedBox(height: height),
                      Row(
                        children: [
                          Container(
                            width: containerWidth,
                            decoration: thinCyan(),
                            child: ListTile(
                              title: Text("Menge"),
                            ),
                          ),
                          SizedBox(width: width),
                          Flexible(
                            flex: 29,
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: new Text(
                                    "-",
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
                                    "+",
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
                SizedBox(height: boxDistance),
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
                  child: Text("Zutat hinzufügen"),
                  style: TextButton.styleFrom(
                    side: BorderSide(width: 2.0, color: Colors.black),
                    backgroundColor: Colors.cyanAccent,
                    minimumSize: Size(0, 45),
                    primary: Colors.black,
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(1),
                    itemCount: ingredientList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Row(
                          children: [
                            Flexible(
                              flex: 18,
                              child: Container(
                                height: 40,
                                decoration: thinTeal(),
                                child: ListTile(
                                  title: Text(
                                    '${ingredientList[index].toString()}',
                                    style: TextStyle(height: 0, fontSize: 20),
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
                                      decoration: symptomsBar(index, amountList),
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
                                sqlFormatedTime != "" &&
                                sqlFormatedDate != null) {
                              int mealID = await addEntry(sqlFormatedDate, sqlFormatedTime, ingredientList, mealName, amount);
                              print(mealID);
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
                                sqlFormatedTime != "" &&
                                sqlFormatedDate != null) {
                              addEntry(sqlFormatedDate, sqlFormatedTime, ingredientList, mealName, amount);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MyApp(),
                                ),
                              );
                              //todo: "Mahlzeit gespeichert" meldung erstellen
                            }
                            //todo: Meldung machen, dass keine Zutat gespeichert ist
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String getText() {
    try {
      final hours = time!.hour.toString().padLeft(2, '0');
      final minutes = time!.minute.toString().padLeft(2, '0');
      return '$hours:$minutes';
    } catch (e) {
      return "";
    }
  }
}

